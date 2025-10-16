import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/bar_chart.dart';
import '../../core/widget/pie_chart.dart';
import '../../core/widget/produit_vendu_widget.dart';
import '../../data/produits.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const DashboardPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, double> pieData = {};
  Map<String, Map<String, double>> barData = {};
  List<String> barLabels = [];
  String userName = "";
  String userEmail = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // ✅ Récupérez l'email et le nom depuis userData
    userEmail = widget.userData['email'] ?? "";
    userName = widget.userData['fullName'] ?? "Utilisateur";

    print('📧 User email: $userEmail');
    print('👤 User name: $userName');

    _loadDashboardData();
  }

  // Fonction pour convertir les données dynamiques en types corrects
  Map<String, double> _convertToPieData(Map<String, dynamic> rawData) {
    Map<String, double> result = {};
    rawData.forEach((key, value) {
      if (value != null) {
        result[key] = value is int ? value.toDouble() : (value as num).toDouble();
      }
    });
    return result;
  }

  Map<String, Map<String, double>> _convertToBarData(Map<String, dynamic> rawData) {
    Map<String, Map<String, double>> result = {};
    rawData.forEach((month, products) {
      if (products is Map<String, dynamic>) {
        result[month] = {};
        products.forEach((product, value) {
          if (value != null) {
            result[month]![product] = value is int ? value.toDouble() : (value as num).toDouble();
          }
        });
      }
    });
    return result;
  }

  Future<void> _loadDashboardData() async {
    try {
      // ✅ Vérifiez d'abord l'email depuis userData
      if (userEmail.isEmpty) {
        print('❌ User email is empty from userData, checking shared preferences...');
        final prefs = await SharedPreferences.getInstance();
        userEmail = prefs.getString('userEmail') ?? "";

        if (userEmail.isEmpty) {
          print('❌ No email found anywhere, using fallback...');
          // Fallback vers l'email de test
          userEmail = "imadferradji@gmail.com";
        }
      }

      print('🔄 Loading dashboard data for: $userEmail');

      // Appeler l'API pour récupérer les données du dashboard
      final response = await http.get(
        Uri.parse('http://localhost:3001/dashboard/$userEmail'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print('✅ Dashboard data loaded successfully');

          // Convertir les données pour les graphiques
          final Map<String, dynamic> rawPieData = Map<String, dynamic>.from(responseData['dashboard']['pieData']);
          final Map<String, dynamic> rawBarData = Map<String, dynamic>.from(responseData['dashboard']['barData']);

          setState(() {
            // Convertir pieData
            pieData = _convertToPieData(rawPieData);

            // Convertir barData
            barData = _convertToBarData(rawBarData);

            barLabels = List<String>.from(responseData['dashboard']['barLabels'] ?? ["Sept", "Oct", "Nov"]);

            // Mettre à jour le nom depuis la réponse API si disponible
            if (responseData['user'] != null && responseData['user']['fullName'] != null) {
              userName = responseData['user']['fullName'];
            }

            isLoading = false;
          });

          print('📊 Pie data: $pieData');
          print('📈 Bar data: $barData');
          print('👤 Final user name: $userName');
        } else {
          print('❌ API returned error: ${responseData['message']}');
          setState(() => isLoading = false);
        }
      } else {
        print('❌ Failed to load dashboard data: ${response.statusCode}');
        print('❌ Response body: ${response.body}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('❌ Error loading dashboard data: $e');
      setState(() => isLoading = false);
    }
  }

  void _refreshData() {
    setState(() {
      isLoading = true;
    });
    _loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Chargement des données...',
              style: TextStyle(
                fontSize: 16,
                color: Appstyle.noir,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Utilisateur: $userEmail',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          const minWidth = 1200.0;
          const minHeight = 900.0;

          final adjustedWidth = screenWidth < minWidth ? minWidth : screenWidth;
          final adjustedHeight = screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV = adjustedHeight * 0.03;
          final paddingH = adjustedWidth * 0.03;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: minWidth,
                  minHeight: minHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: adjustedWidth,
                    height: adjustedHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Side bar
                        Container(
                          width: Responsive.sidebarWidth(adjustedWidth),
                          height: Responsive.sidebarHeight(adjustedHeight),
                          child: SideBarWidget(),
                        ),
                        SizedBox(width: paddingH),
                        // Main Dashboard
                        Expanded(
                          child: Column(
                            children: [
                              // Notification & Compte
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.refresh, color: Appstyle.noir),
                                    onPressed: _refreshData,
                                    tooltip: 'Actualiser les données',
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Image.asset(
                                          "assets/icons/notifications_icon.png",
                                          width: Responsive.notificationSize(adjustedWidth),
                                          height: Responsive.notificationSize(adjustedWidth),
                                          fit: BoxFit.contain,
                                        ),
                                        onPressed: () {
                                          // action
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      AccountWidget(
                                        name: userName,
                                        imageUrl: "assets/images/support.png",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // Text
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Dashboard",
                                        style: Appstyle.textXL_B.copyWith(color: Appstyle.noir)
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: paddingV),
                              // Periode & NEW Periode
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1),
                                  PeriodSelector(),
                                  MainButton(
                                      text: "Periode",
                                      color: Appstyle.rose,
                                      onPressed: () {}
                                  )
                                ],
                              ),
                              SizedBox(height: paddingV),
                              // Produit circle
                              Wrap(
                                spacing: paddingH * 0.8,
                                runSpacing: 16,
                                children: produits.map((produit) {
                                  final double? quantite = pieData[produit.abrev];

                                  return Container(
                                    width: Responsive.produitVenduWidth(adjustedWidth),
                                    height: Responsive.produitVenduHeight(adjustedHeight),
                                    child: ProduitVenduWidget(
                                      produit: produit.abrev,
                                      value: "${quantite?.toInt() ?? 0} Palette",
                                      color: Colors.black,
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: paddingV),
                              // Graph
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: AspectRatio(
                                      aspectRatio: 6 / 3,
                                      child: ProduitBarChart(
                                        months: barLabels,
                                        data: barData,
                                        scaleFactor: 1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: AspectRatio(
                                      aspectRatio: 5 / 3,
                                      child: ProduitPieChart(data: pieData),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}