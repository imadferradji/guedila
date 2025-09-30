import 'package:flutter/material.dart';

import 'SuccessScreen.dart';

class Compte extends StatelessWidget {
  const Compte({super.key});

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
                      // Stepper mockup - Updated active step
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
                                child: const Text(
                                  "N° 0.000202",
                                  style: TextStyle(
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
                                    value: "T' aval programmera",
                                    isExpanded: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    items: const [
                                      DropdownMenuItem(value: "T' aval programmera", child: Text("T' aval programmera")),
                                      DropdownMenuItem(value: "Option 2", child: Text("Option 2")),
                                      DropdownMenuItem(value: "Option 3", child: Text("Option 3")),
                                    ],
                                    onChanged: (value) {
                                      // TODO: handle selection
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
                              // Précédent button
                              SizedBox(
                                width: 140,
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Navigate to previous step
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
                                    elevation: 0, // Remove shadow
                                  ),
                                  child: const Text(
                                    "Précédent",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Oswald",
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3F8CFF), // Blue text
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                height: 42,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SuccessScreen()),
                                      );
                                    },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF482D2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "Suivant →",
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