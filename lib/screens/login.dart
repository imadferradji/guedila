import 'package:flutter/material.dart';

import 'PhoneValidation.dart';
import 'dashboard/dashboard_page.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[200],
    body: Row(
    children: [
      Expanded(
         flex: 1,
        child: Container(
            color: const Color(0xFF58C2EE),
            child: Stack(
            children: [
               Positioned(
                  top: 24,
                  left: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "logo.png",
                        width: 180,
                      ),
                   ],
                  ),
               ),
              const Positioned(
                top: 340,
                bottom: 0,
                left: 200,
                right: 0,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: const [
                      Text(
                        "قناتي...                    ",
                         style: TextStyle(
                           fontSize: 65,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "من المصنع إلى يدك",
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          color: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.all(188),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Center(
                  child: Text(
                    "Connecter a QANATY",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: "Oswald",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                     labelText: "youremail@gmail.com",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      ),
                  ),
                ),
                SizedBox(height: 30),
               Text(
                  " Mot de passe",
                  style: TextStyle(
                    fontFamily: "Oswald",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
               ),
               SizedBox(height: 10),
               TextField(
                 obscureText: true,
                 decoration: InputDecoration(
                   labelText: "••••••••",
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
               ),
               const SizedBox(height: 16),
               Row(
                children: [
                  Checkbox(value: true, onChanged: (_) {}),
                  const Text("Sauvegarder",style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Oswald",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,),),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Mot de passe oublié ?",style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Oswald",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,),),
                  ),
                ],
               ),
               const SizedBox(height: 16),
               Center(
                 child: SizedBox(
                   width: 200,
                   height: 42,
                   child: ElevatedButton(
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => DashboardPage()), // 👈 target page
                       );
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xFFF482D2),
                       padding: const EdgeInsets.symmetric(vertical: 14),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(14), // 👈 Bigger = more rounded
                       ),
                     ),
                     child: const Text(
                       "Connecter  →  ",
                       style: TextStyle(
                         fontSize: 18,
                         fontFamily: "Oswald",
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
               ),
               const SizedBox(height: 16),
               Center(
                 child: TextButton(
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) =>PhoneValidation()), // 👈 target page
                     );
                   },
                   child: const Text("Crée un compte?",
                     style: TextStyle(
                       fontFamily: "Oswald",
                       color: Color(0xFF3F8CFF),
                       fontWeight: FontWeight.bold,),),
                 ),
               ),
             ],
          ),
        ),
      ),
    ],
    ),
  );
  }
  }
