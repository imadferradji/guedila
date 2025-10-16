import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'api_service.dart';
import 'PhoneValidation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = true;

  Future<void> _login() async {
    // Validate fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      print('🔄 Starting login process...');

      final response = await ApiService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      final responseData = json.decode(response.body);

      print('📊 Response data: $responseData');

      if (response.statusCode == 200 && responseData['success'] == true) {
        // Login successful
        print('✅ Login successful, navigating to dashboard...');

        // Stocker les informations utilisateur
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', _emailController.text.trim());
        await prefs.setString('userName', responseData['user']['fullName'] ?? 'Utilisateur');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connexion réussie!'),
            backgroundColor: Colors.green,
          ),
        );

        // Wait a bit for the user to see the success message
        await Future.delayed(const Duration(milliseconds: 1000));

        // Navigate to dashboard
        if (mounted) {
          context.go('/dashboard', extra: {
            'email': responseData['user']['email'],
            'fullName': responseData['user']['fullName'] ?? 'Utilisateur',
          });
        }

      } else {
        // Login failed
        print('❌ Login failed with status: ${response.statusCode}');
        final errorMessage = responseData['message'] ?? 'Email ou mot de passe incorrect';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('❌ Login error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de connexion: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                    child: Image.asset(
                      "logo.png",
                      width: 180,
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
                        children: [
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
                  const Center(
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
                  const SizedBox(height: 30),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "youremail@gmail.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    " Mot de passe",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
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
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
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
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF482D2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
                          MaterialPageRoute(builder: (context) => const PhoneValidation()),
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