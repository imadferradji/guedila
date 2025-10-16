import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';
import '../../core/theme/app_style.dart';
import '../../core/widget/commander_produit_dialog.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/solde_widget.dart';
import 'dart:convert';
import '../api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandePage extends StatefulWidget {
  final String username = "Oussama Bensbaa";
  final double solde = 100000.00;

  const CommandePage({Key? key}) : super(key: key);

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _commandes = [];
  bool _isLoading = true;
  String _userEmail = '';
  String _userName = '';
  int _soldeWidgetKey = 0; // Key to force rebuild

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  void _onCommandeCreated() {
    print('🔄 Refreshing commandes and solde after new command...');
    _refreshCommandes();
    _refreshSolde(); // Refresh solde after command creation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Commande créée avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _userEmail = prefs.getString('userEmail') ?? '';
        _userName = prefs.getString('userName') ?? 'Utilisateur';
      });
      await _loadCommandes();
    } catch (e) {
      print('❌ Error loading user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCommandes() async {
    try {
      if (_userEmail.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('🔄 Loading commandes for: $_userEmail');

      final response = await ApiService.getUserCommandes(_userEmail);
      final responseData = json.decode(response.body);

      print('📊 Commandes response: ${response.statusCode}');
      print('📦 Commandes data: $responseData');

      if (response.statusCode == 200 && responseData['success'] == true) {
        setState(() {
          _commandes = responseData['commandes'] ?? [];
          _isLoading = false;
        });
        print('✅ Loaded ${_commandes.length} commandes');
      } else {
        setState(() {
          _isLoading = false;
        });
        print('❌ Failed to load commandes: ${responseData['message']}');

        // Show error to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'] ?? 'Erreur lors du chargement des commandes'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('❌ Error loading commandes: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de connexion: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _refreshCommandes() async {
    setState(() {
      _isLoading = true;
    });
    await _loadCommandes();
  }

  Future<void> _refreshSolde() async {
    if (mounted) {
      setState(() {
        _soldeWidgetKey++; // This will force the SoldeWidget to rebuild
      });
    }
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
                            child: const SideBarWidget()
                        ),
                        SizedBox(width: paddingH),
                        Expanded(
                          child: Column(
                            children: [
                              // Header with notifications and account
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/icons/notifications_icon.png",
                                      width: Responsive.notificationSize(adjustedWidth),
                                      height: Responsive.notificationSize(adjustedWidth),
                                      fit: BoxFit.contain,
                                    ),
                                    onPressed: () {
                                      // Notification action
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  AccountWidget(
                                      name: _userName,
                                      imageUrl: "assets/images/support.png"
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Title and balance
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Commandes",
                                      style: Appstyle.textXL_B.copyWith(color: Appstyle.noir)
                                  ),
                                  SoldeWidget(
                                    key: Key('solde_$_soldeWidgetKey'), // This forces rebuild when key changes
                                    dernier_modif: "24/02/2025",
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // Period selector and new order button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 1),
                                  const PeriodSelector(),
                                  MainButton(
                                    text: "Nouvelle Commande",
                                    color: Appstyle.rose,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor: Appstyle.blueF.withOpacity(0.3),
                                        builder: (context) {
                                          return CommanderProduitDialog(
                                            solde: widget.solde,
                                            onCommandeCreated: _onCommandeCreated,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // My orders title and search
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Mes commandes",
                                      style: Appstyle.textL_B
                                  ),
                                  SizedBox(
                                    width: 412,
                                    child: SearchField(controller: _controller),
                                  )
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Commandes list
                              Expanded(
                                  child: _buildCommandesList(adjustedHeight)
                              )
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

  Widget _buildCommandesList(double adjustedHeight) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Chargement des commandes...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (_commandes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "Aucune commande trouvée",
              style: Appstyle.textL_B.copyWith(color: Appstyle.gris),
            ),
            const SizedBox(height: 8),
            Text(
              "Créez votre première commande en cliquant sur 'Nouvelle Commande'",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MainButton(
              text: "Nouvelle Commande",
              color: Appstyle.rose,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Appstyle.blueF.withOpacity(0.3),
                  builder: (context) {
                    return CommanderProduitDialog(
                      solde: widget.solde,
                      onCommandeCreated: _onCommandeCreated,
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshCommandes,
      child: ListView.builder(
        itemCount: _commandes.length,
        itemBuilder: (context, index) {
          final commande = _commandes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: FactureWidget(
              quantite: commande['quantite']?.toString() ?? "N/A",
              produit: commande['produit']?.toString() ?? "N/A",
              livre: commande['livre']?.toString() ?? "Non livré",
              pallete: commande['pallete']?.toString() ?? "Non",
              montant: _formatMontant(commande['montant']),
              date: commande['date']?.toString() ?? "N/A",
              etat: _getEtatText(commande['etat']?.toString() ?? 'En attente'),
            ),
          );
        },
      ),
    );
  }

  String _formatMontant(dynamic montant) {
    if (montant == null) return "0.00";

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
      case 'permis':
        return 'Permis';
      case 'livrée':
      case 'livree':
        return 'Livrée';
      case 'annulée':
      case 'annulee':
        return 'Annulée';
      default:
        return 'En attente';
    }
  }
}