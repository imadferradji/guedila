// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3001';

  // ================================
  // 🔐 AUTHENTIFICATION
  // ================================

  // Connexion utilisateur
  static Future<http.Response> login(String email, String password) async {
    try {
      print('🌐 Attempting login for: $email');
      print('📍 Connecting to: $baseUrl/auth/login');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email.trim(),
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      print('✅ Login response status: ${response.statusCode}');
      print('✅ Login response body: ${response.body}');

      return response;
    } on http.ClientException catch (e) {
      print('❌ HTTP Client Exception: $e');
      throw Exception('Erreur de connexion au serveur. Vérifiez votre connexion internet.');
    } on FormatException catch (e) {
      print('❌ Format Exception: $e');
      throw Exception('Erreur de format de données.');
    } on Exception catch (e) {
      print('❌ General Exception: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Inscription - Étape 1
  static Future<http.Response> registerStep1({
    required String email,
    required String password,
    required String phone,
    required String phoneCode,
    required String smsCode,
  }) async {
    try {
      print('🌐 Connecting to: $baseUrl/auth/register/step1');
      print('📤 Sending data: {email: $email, phone: $phone, phoneCode: $phoneCode, smsCode: $smsCode}');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/step1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'phone': phone,
          'phoneCode': phoneCode,
          'smsCode': smsCode,
        }),
      ).timeout(const Duration(seconds: 15));

      print('✅ Response status: ${response.statusCode}');
      print('✅ Response body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ Network error: $e');
      throw Exception(
        'Impossible de se connecter au serveur. Veuillez vérifier:\n'
            '1️⃣ Le serveur est en cours d\'exécution\n'
            '2️⃣ L\'adresse IP est correcte\n'
            '3️⃣ La connexion réseau fonctionne',
      );
    }
  }

  // Inscription - Étape 2
  static Future<http.Response> registerStep2({
    required String email,
    required String fullName,
    required String birthDate,
    required String company,
    required String wilaya,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/step2'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'fullName': fullName,
          'birthDate': birthDate,
          'company': company,
          'wilaya': wilaya,
        }),
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Inscription - Étape 3
  static Future<http.Response> registerStep3({
    required String email,
    required String accountNumber,
    required String category,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register/step3'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'accountNumber': accountNumber,
          'category': category,
        }),
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // ================================
  // 📊 FONCTION POUR RÉCUPÉRER LES DONNÉES DU DASHBOARD
  // ================================

  static Future<http.Response> getDashboardData(String email) async {
    try {
      print('🌐 Fetching dashboard data for: $email');
      print('📍 Connecting to: $baseUrl/dashboard/$email');

      final response = await http.get(
        Uri.parse('$baseUrl/dashboard/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      print('✅ Dashboard response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ Dashboard data fetched successfully');
      } else {
        print('❌ Failed to fetch dashboard data: ${response.body}');
      }

      return response;
    } on http.ClientException catch (e) {
      print('❌ HTTP Client Exception: $e');
      throw Exception('Erreur de connexion au serveur. Vérifiez votre connexion internet.');
    } on FormatException catch (e) {
      print('❌ Format Exception: $e');
      throw Exception('Erreur de format de données.');
    } on Exception catch (e) {
      print('❌ General Exception: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }
  //=================================
  //======GET USER Solde=============
  static Future<http.Response> getUserSolde(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/accounts/solde/$email'),
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      print('❌ Error getting user solde: $e');
      rethrow;
    }
  }
  //================================
  //================================
// 📦 COMMANDES
// ================================

// Récupérer les commandes d'un utilisateur
  static Future<http.Response> getUserCommandes(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/commandes/user/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

// Créer une nouvelle commande
  static Future<http.Response> createCommande({
    required String userEmail,
    required String quantite,
    required String produit,
    required String dateCommande,
    required String montant,
    required String pallete,
  }) async {
    try {
      final requestBody = {
        'user_email': userEmail,
        'quantite': quantite,
        'produit': produit,
        'date_commande': dateCommande,
        'montant': montant,
        'pallete': pallete,
        'etat': 'En attente',
      };

      print('📤 Sending create commande request:');
      print('   📧 User: $userEmail');
      print('   🏷️ Produit: $produit');
      print('   🔢 Quantite: $quantite');
      print('   💰 Montant: $montant');
      print('   📦 Palette: $pallete');
      print('   📅 Date: $dateCommande');

      final response = await http.post(
        Uri.parse('$baseUrl/commandes/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      print('📥 Create commande response: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ Error creating commande: $e');
      rethrow;
    }
  }
// ================================
// 🏦 VIREMENTS
// ================================

// Récupérer les virements d'un utilisateur
  static Future<http.Response> getUserVirements(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/virements/user/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

// Créer un nouveau virement
  static Future<http.Response> createVirement({
    required String userEmail,
    required String numero,
    required String montant,
    required String dateVirement,
    required String? imagePath,
  }) async {
    try {
      final requestBody = {
        'user_email': userEmail,
        'numero': numero,
        'montant': montant,
        'date_virement': dateVirement,
        'image_path': imagePath,
      };

      print('📤 Sending create virement request:');
      print('   📧 User: $userEmail');
      print('   🔢 Numéro: $numero');
      print('   💰 Montant: $montant');
      print('   📅 Date: $dateVirement');

      final response = await http.post(
        Uri.parse('$baseUrl/virements/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      print('📥 Create virement response: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ Error creating virement: $e');
      rethrow;
    }
  }
  // Dans api_service.dart - ajoutez cette fonction
  static Future<http.Response> getUserFactures(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/commandes/user/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
  // ================================
// 🚛 CAMIONS
// ================================

// Récupérer tous les camions
  static Future<http.Response> getCamions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/driver-truck/camions'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

// Ajouter un nouveau camion
  static Future<http.Response> createCamion({
    required String matricule,
    required String matriculeRemorque,
    required String type,
    required double tonnage,
    String? marque,
    String? modele,
    int? annee,
    String? couleur,
    String? dateMiseCirculation,
    String? statut,
    required String createdBy,
  }) async {
    try {
      final requestBody = {
        'matricule': matricule,
        'matricule_remorque': matriculeRemorque,
        'type': type,
        'tonnage': tonnage,
        'marque': marque,
        'modele': modele,
        'annee': annee,
        'couleur': couleur,
        'date_mise_circulation': dateMiseCirculation,
        'statut': statut,
        'created_by': createdBy,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/driver-truck/camions/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      return response;
    } catch (e) {
      print('❌ Error creating camion: $e');
      rethrow;
    }
  }

// Modifier l'état d'un camion
  static Future<http.Response> updateCamionEtat({
    required int camionId,
    required String etat,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/driver-truck/camions/$camionId/etat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'etat': etat}),
      );

      return response;
    } catch (e) {
      print('❌ Error updating camion state: $e');
      rethrow;
    }
  }

// ================================
// 👨‍💼 CHAUFFEURS
// ================================

// Récupérer tous les chauffeurs
  static Future<http.Response> getChauffeurs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/driver-truck/chauffeurs'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

// Ajouter un nouveau chauffeur
  static Future<http.Response> createChauffeur({
    required String nomComplet,
    required String numeroPermis,
    required String dateNaissance,
    required String telephone,
    String? photoPath,
    required String createdBy,
  }) async {
    try {
      final requestBody = {
        'nom_complet': nomComplet,
        'numero_permis': numeroPermis,
        'date_naissance': dateNaissance,
        'telephone': telephone,
        'photo_path': photoPath,
        'created_by': createdBy,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/driver-truck/chauffeurs/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      return response;
    } catch (e) {
      print('❌ Error creating chauffeur: $e');
      rethrow;
    }
  }

// Modifier l'état d'un chauffeur
  static Future<http.Response> updateChauffeurEtat({
    required int chauffeurId,
    required String etat,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/driver-truck/chauffeurs/$chauffeurId/etat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'etat': etat}),
      );

      return response;
    } catch (e) {
      print('❌ Error updating chauffeur state: $e');
      rethrow;
    }
  }
}