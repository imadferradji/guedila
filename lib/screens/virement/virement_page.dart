import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/virement_dialog.dart';
import '../../core/widget/virement_widget.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service.dart';

class VirementPage extends StatefulWidget {
  VirementPage({Key? key}) : super(key: key);

  @override
  State<VirementPage> createState() => _VirementPageState();
}

class _VirementPageState extends State<VirementPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _virements = [];
  bool _isLoading = true;
  String _userEmail = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _userEmail = prefs.getString('userEmail') ?? '';
        _userName = prefs.getString('userName') ?? 'Utilisateur';
      });
      await _loadVirements();
    } catch (e) {
      print('❌ Error loading user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadVirements() async {
    try {
      if (_userEmail.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('🔄 Loading virements for: $_userEmail');

      final response = await ApiService.getUserVirements(_userEmail);
      final responseData = json.decode(response.body);

      print('📊 Virements response: ${response.statusCode}');
      print('📦 Virements data: $responseData');

      if (response.statusCode == 200 && responseData['success'] == true) {
        setState(() {
          _virements = responseData['virements'] ?? [];
          _isLoading = false;
        });
        print('✅ Loaded ${_virements.length} virements');
      } else {
        setState(() {
          _isLoading = false;
        });
        print('❌ Failed to load virements: ${responseData['message']}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('❌ Error loading virements: $e');
    }
  }

  void _onVirementCreated() {
    print('🔄 Refreshing virements after new virement...');
    _refreshVirements();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Virement créé avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _refreshVirements() async {
    setState(() {
      _isLoading = true;
    });
    await _loadVirements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder:(context, constraints) {
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
                            width:Responsive.sidebarWidth(adjustedWidth),
                            height:Responsive.sidebarHeight(adjustedHeight),
                            child: SideBarWidget()
                        ),
                        SizedBox(width: paddingH,),
                        // MainVirement
                        Expanded(
                          child: Column(
                            children: [
                              // notif acount
                              Row (
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(adjustedWidth),
                                      height: Responsive.notificationSize(adjustedWidth),
                                      fit: BoxFit.contain,
                                    ),
                                    onPressed: () {},
                                  ),
                                  AccountWidget(name: _userName, imageUrl: "assets/images/support.png"),
                                  SizedBox(width: 16,),
                                ],
                              ),
                              // Title
                              Row(
                                children: [
                                  Text("Virement", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20),
                              // Period selector and new virement button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1,),
                                  PeriodSelector(),
                                  MainButton(
                                    text: "Virement",
                                    color: Appstyle.rose,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor: Appstyle.blueF.withOpacity(0.3),
                                        builder: (context) {
                                          return VirementDialog(
                                            onVirementCreated: _onVirementCreated,
                                            userEmail: _userEmail,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              // My virements title and search
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes virements", style: Appstyle.textL_B,),
                                  SizedBox(
                                    width: 412,
                                    child:  SearchField(controller: _controller,),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              // Virements list
                              Expanded(
                                  child: _buildVirementsList(adjustedWidth, adjustedHeight, paddingH)
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

  Widget _buildVirementsList(double adjustedWidth, double adjustedHeight, double paddingH) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Chargement des virements...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (_virements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payment_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "Aucun virement trouvé",
              style: Appstyle.textL_B.copyWith(color: Appstyle.gris),
            ),
            const SizedBox(height: 8),
            Text(
              "Créez votre premier virement en cliquant sur 'Virement'",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshVirements,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: paddingH * 1.5,
          mainAxisSpacing: 26,
          childAspectRatio: 280 / 170,
        ),
        itemCount: _virements.length,
        itemBuilder: (context, index) {
          final virement = _virements[index];
          return VirementWidget(
            numero: virement['numero']?.toString() ?? "N/A",
            montant: _formatMontant(virement['montant']),
            date: virement['date']?.toString() ?? "N/A",
            etat: _getEtatText(virement['etat']?.toString() ?? 'En attente'),
          );
        },
      ),
    );
  }

  String _formatMontant(dynamic montant) {
    if (montant == null) return "0.00 DA";

    try {
      if (montant is String) {
        return '${double.parse(montant).toStringAsFixed(2)} DA';
      } else if (montant is num) {
        return '${montant.toDouble().toStringAsFixed(2)} DA';
      }
      return "0.00 DA";
    } catch (e) {
      return "0.00 DA";
    }
  }

  String _getEtatText(String etat) {
    switch (etat.toLowerCase()) {
      case 'en attente':
        return 'En attente';
      case 'validé':
      case 'valide':
        return 'Validé';
      case 'rejeté':
      case 'rejete':
        return 'Rejeté';
      default:
        return 'En attente';
    }
  }
}