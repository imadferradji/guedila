import 'package:flutter/material.dart';

import 'dashboard/dashboard_page.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // ---- Left Blue Side ----
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
                      // Stepper mockup - All steps completed
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          StepItem(text: "Validez votre téléphone", active: true),
                          StepItem(text: "À propos de vous", active: true),
                          StepItem(text: "Compte", active: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // ---- Right White Success Side ----
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Success illustration
                        Image.asset(
                          "success.png",
                          width: 300,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40),

                        // Success message
                        const Text(
                          "Vous êtes inscrit avec succès!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Oswald",
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Commencer button with arrow
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DashboardPage()), // 👈 target page
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF482D2), // Pink background
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Commencer",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Oswald",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
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
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            color: active ? Colors.green : Colors.white,
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