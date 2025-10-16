import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/etat_facture_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/print_dialog.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/facture_model.dart';
import '../api_service.dart';

class DocumentPage extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPage();
}

class _DocumentPage extends State<DocumentPage> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  bool facSide = false;
  bool isLoading = true;
  List<Facture> factures = [];
  List<Facture> filteredFactures = [];

  @override
  void initState() {
    super.initState();
    _loadFactures();
  }

  Future<void> _loadFactures() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await ApiService.getUserFactures("imadferradji@gmail.com"); // Remplacez par l'email de l'utilisateur connecté

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          List<dynamic> commandesData = data['commandes'];
          setState(() {
            factures = commandesData.map((json) => Facture.fromJson(json)).toList();
            filteredFactures = List.from(factures);
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // Gérer l'erreur
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('❌ Error loading factures: $e');
    }
  }

  void _filterFactures(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFactures = List.from(factures);
      } else {
        filteredFactures = factures.where((facture) =>
        facture.produit.toLowerCase().contains(query.toLowerCase()) ||
            facture.quantite.toLowerCase().contains(query.toLowerCase()) ||
            facture.montant.contains(query)
        ).toList();
      }
    });
  }

  void _imprimerFacture(Facture facture) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PrintDialog(facture: facture);
      },
    );
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    dateFromController.dispose();
    dateToController.dispose();
    super.dispose();
  }

  double get _montantTotal {
    return filteredFactures.fold(0, (sum, facture) => sum + double.parse(facture.montant));
  }

  int get _nombrePalettesTotal {
    return filteredFactures.where((f) => f.pallete == 'Oui').length;
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
                            width: Responsive.sidebarWidth(adjustedWidth),
                            height: Responsive.sidebarHeight(adjustedHeight),
                            child: SideBarWidget()
                        ),
                        SizedBox(width: paddingH),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
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
                                  AccountWidget(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png"),
                                  SizedBox(width: 16),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Document", style: Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EtatWidget(
                                    initialSelectedIndex: facSide ? 1 : 0,
                                    onChanged: (index) {
                                      setState(() {
                                        facSide = index == 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 90),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mes factures", style: Appstyle.textL_B),
                                  facSide
                                      ? SizedBox(
                                    width: 412,
                                    child: SearchField(
                                      controller: _controller,
                                      onChanged: _filterFactures,
                                    ),
                                  )
                                      : Row(
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: dateFromController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Date du",
                                            prefixIcon: Icon(Icons.calendar_today, color: Appstyle.blueC),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onTap: () => selectDate(context, dateFromController),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 180,
                                        child: TextField(
                                          controller: dateToController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Date au",
                                            prefixIcon: Icon(Icons.calendar_today, color: Appstyle.blueC),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                color: Appstyle.blueC,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onTap: () => selectDate(context, dateToController),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Container(
                                width: double.infinity,
                                height: adjustedHeight * 0.5,
                                child: isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SingleChildScrollView(
                                  child: !facSide
                                      ? Column(
                                    children: filteredFactures.map((facture) {
                                      return Column(
                                        children: [
                                          FactureWidget(
                                            quantite: facture.quantite,
                                            produit: facture.produit,
                                            livre: facture.dateLivraison,
                                            pallete: facture.pallete,
                                            montant: facture.montant,
                                            date: facture.dateCommande,
                                            etat: facture.etat,
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      );
                                    }).toList(),
                                  )
                                      : Column(
                                    children: filteredFactures.map((facture) {
                                      return Column(
                                        children: [
                                          FactureImprimerWidget(
                                            quantite: facture.quantite,
                                            produit: facture.produit,
                                            livre: facture.dateLivraison,
                                            pallete: facture.pallete,
                                            montant: facture.montant,
                                            date: facture.dateCommande,
                                            onPressed: () => _imprimerFacture(facture),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              facSide
                                  ? Container()
                                  : Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Appstyle.blueC,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Appstyle.gris.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "Montant total: ${_montantTotal.toStringAsFixed(2)} Da",
                                            style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50),
                                  SizedBox(
                                    height: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Appstyle.blueC,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Appstyle.gris.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "Nombre Palettes total: $_nombrePalettesTotal",
                                            style: Appstyle.textM_B.copyWith(color: Appstyle.blanc),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50),
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