import 'package:flutter/material.dart';
import 'AboutYou.dart';

class PhoneValidation extends StatelessWidget {
  const PhoneValidation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Padding around the entire screen
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
                      // Stepper mockup
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          StepItem(text: "Validez votre téléphone", active: true),
                          StepItem(text: "À propos de vous"),
                          StepItem(text: "Compte"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20), // Space between the two sides

            // ---- Right White Form Side ----
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners for white side
                  color: Colors.white,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "ETAPE 1/3",
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
                            "Validez votre téléphone",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Oswald",
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Phone number input
                        const Text(
                          "N° téléphone",
                          style: TextStyle(
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: "+213",
                                  items: const [
                                    DropdownMenuItem(value: "+213", child: Text("+213")),
                                    DropdownMenuItem(value: "+1", child: Text("+1")),
                                    DropdownMenuItem(value: "+33", child: Text("+33")),
                                  ],
                                  onChanged: (value) {
                                    // TODO: handle selection
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "345 567-23-56",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // SMS code
                        const Text(
                          "Code de SMS",
                          style: TextStyle(
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            4,
                                (index) => Container(
                              width: 50,
                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(""),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFEBF3FF),
                          ),
                          child: const Text(
                            "Un SMS a été envoyé à votre numéro :\n  +1 345 673-56-67\n Valable jusqu'à 1h25",
                            style: TextStyle(
                              fontFamily: "Oswald",
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Email
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "youremail@gmail.com",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Password
                        const Text(
                          "Crée un mot de passe",
                          style: TextStyle(
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility_outlined),
                            hintText: "••••••••",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Button aligned right
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 140,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AboutYou()), // 👈 target page
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF482D2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
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