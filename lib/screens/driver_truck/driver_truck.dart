import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/camion_dialog.dart';
import 'package:qanaty/core/widget/chauffeur_camion%20_widget.dart';
import 'package:qanaty/core/widget/chauffeur_dialog.dart';
import 'package:qanaty/core/widget/chauffeur_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import 'package:qanaty/data/camions.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/camion_widget.dart';
import '../../core/widget/etat_facture_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/search_field.dart';
import '../../data/chauffeurs.dart';
import '../../screens/api_service.dart';

class DriverTruckPage extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  DriverTruckPage({Key? key}) : super(key: key);

  @override
  State<DriverTruckPage> createState() => _DriverTruckPage();
}

class _DriverTruckPage extends State<DriverTruckPage> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  bool camioSide = false;

  // Add these lists to store real data from API
  List<dynamic> _chauffeursList = [];
  List<dynamic> _camionsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from API
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (!camioSide) {
        // Load chauffeurs
        final response = await ApiService.getChauffeurs();
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Chauffeurs API response: $data');

          // Extract data from the response format: {success: true, data: [...]}
          if (data is Map && data.containsKey('data') && data['data'] is List) {
            setState(() {
              _chauffeursList = data['data'];
            });
            print('Loaded ${_chauffeursList.length} chauffeurs');
          } else {
            print('Unexpected chauffeurs response format: $data');
            // Fallback to mock data if API fails
            setState(() {
              _chauffeursList = chauffeurs;
            });
          }
        } else {
          print('Failed to load chauffeurs: ${response.statusCode}');
          // Fallback to mock data if API fails
          setState(() {
            _chauffeursList = chauffeurs;
          });
        }
      } else {
        // Load camions
        final response = await ApiService.getCamions();
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Camions API response: $data');

          // Extract data from the response format: {success: true, data: [...]}
          if (data is Map && data.containsKey('data') && data['data'] is List) {
            setState(() {
              _camionsList = data['data'];
            });
            print('Loaded ${_camionsList.length} camions');
          } else {
            print('Unexpected camions response format: $data');
            // Fallback to mock data if API fails
            setState(() {
              _camionsList = camions;
            });
          }
        } else {
          print('Failed to load camions: ${response.statusCode}');
          // Fallback to mock data if API fails
          setState(() {
            _camionsList = camions;
          });
        }
      }
    } catch (e) {
      print('Error loading data: $e');
      // Fallback to mock data if API fails
      setState(() {
        _chauffeursList = chauffeurs;
        _camionsList = camions;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Refresh data when switching between chauffeurs and camions
  void _handleTabChange(int index) {
    setState(() {
      camioSide = index == 1;
    });
    _loadData();
  }

  // Refresh data after adding new item
  void _refreshData() {
    _loadData();
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
                              // Notification et Account
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

                              // Titre
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Chauffeurs & Camions", style: Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                ],
                              ),
                              SizedBox(height: 20),

                              // Button camion & chauffeur
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ChauffeurCamionWidget(
                                    initialSelectedIndex: camioSide ? 1 : 0,
                                    onChanged: _handleTabChange,
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),

                              // Nouveau button
                              Align(
                                alignment: Alignment.topRight,
                                child: MainButton(
                                  text: camioSide ? "Nouveau camion" : "Nouveau chauffeur",
                                  color: Appstyle.rose,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierColor: Appstyle.blueF.withOpacity(0.3),
                                      builder: (context) {
                                        return camioSide
                                            ? CamionDialog(onCamionAdded: _refreshData)
                                            : DriverDialog(onChauffeurAdded: _refreshData);
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 20),

                              // Mini Titre & search field
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(camioSide ? "Mes camions" : "Mes chauffeurs", style: Appstyle.textL_B),
                                  SizedBox(
                                    width: 412,
                                    child: SearchField(controller: _controller),
                                  )
                                ],
                              ),

                              SizedBox(height: 40),

                              // Data list
                              Container(
                                width: double.infinity,
                                height: adjustedHeight * 0.5,
                                child: _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : SingleChildScrollView(
                                  child: camioSide
                                      ? _buildCamionsList()
                                      : _buildChauffeursList(),
                                ),
                              ),
                              SizedBox(height: 30),
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

  Widget _buildChauffeursList() {
    if (_chauffeursList.isEmpty) {
      return Center(
        child: Text(
          "Aucun chauffeur trouvé",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        ..._chauffeursList.expand((chauffeur) {
          // Handle the API response format
          final chauffeurData = chauffeur as Map<String, dynamic>;

          final id = chauffeurData['id'];
          final nom = chauffeurData['nom_complet']; // API uses 'nom_complet'
          final dateNaissance = chauffeurData['date_naissance'];
          final npermis = chauffeurData['numero_permis']; // API uses 'numero_permis'
          final ntelephone = chauffeurData['telephone']; // API uses 'telephone'
          final etat = chauffeurData['etat'];

          // Format date if it exists
          String formattedDate = 'Non spécifié';
          if (dateNaissance != null) {
            final date = DateTime.parse(dateNaissance);
            formattedDate = "${date.day}/${date.month}/${date.year}";
          }

          return [
            ChauffeurWidget(
              id: id ?? 0,
              Nom: nom?.toString() ?? 'Non spécifié',
              datenaissance: formattedDate,
              npermis: npermis?.toString() ?? 'Non spécifié',
              ntelephone: ntelephone?.toString() ?? 'Non spécifié',
              etat: etat?.toString() ?? 'Actif',
            ),
            const SizedBox(height: 10),
          ];
        }).toList(),
      ],
    );
  }

  Widget _buildCamionsList() {
    if (_camionsList.isEmpty) {
      return Center(
        child: Text(
          "Aucun camion trouvé",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        ..._camionsList.expand((camion) {
          // Handle the API response format
          final camionData = camion as Map<String, dynamic>;

          final id = camionData['id'];
          final matricule = camionData['matricule']; // API uses 'matricule'
          final matriculeRemorque = camionData['matricule_remorque']; // API uses 'matricule_remorque'
          final type = camionData['type'];
          final tonnage = camionData['tonnage'];
          final etat = camionData['etat'];

          return [
            CamionWidget(
              id: id ?? 0,
              Matricule: matricule?.toString() ?? 'Non spécifié',
              MatriculeR: matriculeRemorque?.toString() ?? 'Non spécifié',
              tonnage: tonnage?.toString() ?? 'Non spécifié',
              etat: etat?.toString() ?? 'Actif',
              type: type?.toString() ?? 'Non spécifié',
            ),
            const SizedBox(height: 10),
          ];
        }).toList(),
      ],
    );
  }
}