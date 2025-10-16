import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api_service.dart';

class Compte extends StatefulWidget {
  final String email;

  const Compte({super.key, required this.email});

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  String _selectedCategory = "T' aval programmera";
  bool _isLoading = false;

  // This would typically come from previous steps or be generated
  final String _accountNumber = "N° ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

  Future<void> _completeRegistration() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.registerStep3(
        email: widget.email,
        accountNumber: _accountNumber,
        category: _selectedCategory,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscription terminée avec succès!')),
        );

        if (!mounted) return;
        // ✅ Use go_router instead of Navigator
        context.go('/success');
      } else {
        final errorData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Erreur est survenue')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFF58C2EE),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "logo.png",
                        width: 140,
                      ),
                      const SizedBox(height: 60),
                      const Text(
                        "Commencer",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Oswald",
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          StepItem(text: "Validez votre téléphone", active: false),
                          StepItem(text: "À propos de vous", active: false),
                          StepItem(text: "Compte", active: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20,left:20,bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "ETAPE 3/3",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Oswald",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3F8CFF),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Center(
                                child: Text(
                                  "Compte",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Oswald",
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),

                              // N° de compte
                              const Text(
                                "N° de compte",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[50],
                                ),
                                child: Text(
                                  _accountNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Oswald",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Catégorie - Dropdown list
                              const Text(
                                "Catégorie",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCategory,
                                    isExpanded: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    items: const [
                                      DropdownMenuItem(value: "T' aval programmera", child: Text("T' aval programmera")),
                                      DropdownMenuItem(value: "Développeur", child: Text("Développeur")),
                                      DropdownMenuItem(value: "Designer", child: Text("Designer")),
                                      DropdownMenuItem(value: "Manager", child: Text("Manager")),
                                      DropdownMenuItem(value: "Consultant", child: Text("Consultant")),
                                      DropdownMenuItem(value: "Entrepreneur", child: Text("Entrepreneur")),
                                      DropdownMenuItem(value: "Freelancer", child: Text("Freelancer")),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCategory = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF3F8CFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: const BorderSide(
                                        color: Color(0xFF3F8CFF),
                                        width: 2.0,
                                      ),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "Précédent",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Oswald",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3F8CFF),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                height: 42,
                                child: _isLoading
                                    ? const Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                  onPressed: _completeRegistration,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF482D2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "Terminer",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Oswald",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final String text;
  final bool active;
  const StepItem({super.key, required this.text, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            active ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: "Oswald",
              fontSize: 16,
              color: Colors.white.withOpacity(active ? 1 : 0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}