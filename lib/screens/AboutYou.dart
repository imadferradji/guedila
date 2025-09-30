import 'package:flutter/material.dart';
import 'package:untitled/screens/Compte.dart';

import 'PhoneValidation.dart';

class AboutYou extends StatelessWidget {
  const AboutYou({super.key});

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
                          StepItem(text: "À propos de vous", active: true),
                          StepItem(text: "Compte", active: false),
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
                                  "ETAPE 2/3",
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
                                  "À propos de vous",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Oswald",
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Nom et prénom
                              const Text(
                                "Nom et prénom",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Voter Nom et prenom",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Color when not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.blue, // Color when focused
                                      width: 2.0,
                                    ),
                                  ),
                                ),),
                              const SizedBox(height: 20),
                              const Text(
                                "Date de naissance",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Voter Date de naissance",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Color when not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.blue, // Color when focused
                                      width: 2.0,
                                    ),
                                  ),
                                ),),
                              const SizedBox(height: 20),

                              // Nom de société
                              const Text(
                                "Nom de société",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Oswald",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Le Nom de société",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Color when not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.blue, // Color when focused
                                      width: 2.0,
                                    ),
                                  ),
                                ),),

                              const SizedBox(height: 20),

                              const Text(
                                "Wilaya",
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
                                    value: "Biskra",
                                    isExpanded: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    items: const [
                                      DropdownMenuItem(value: "Biskra", child: Text("Biskra")),
                                      DropdownMenuItem(value: "Batna", child: Text("Batna")),
                                      DropdownMenuItem(value: "Misla", child: Text("Msila")),
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
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 140,
                                  height: 42,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PhoneValidation()), // 👈 target page
                                      );
                                    },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, // White background
                                    foregroundColor: const Color(0xFF3F8CFF), // Blue text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: const BorderSide(
                                        color: Color(0xFF3F8CFF), // Blue border
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
                                        MaterialPageRoute(builder: (context) => const Compte()), // 👈 target page
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF482D2), // Pink background
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 0, // Remove shadow
                                    ),
                                    child: const Text(
                                      "Suivant →",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Oswald",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // White text
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