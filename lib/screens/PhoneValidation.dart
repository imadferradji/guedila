import 'dart:convert';
import 'package:flutter/material.dart';
import 'AboutYou.dart';
import 'api_service.dart';

class PhoneValidation extends StatefulWidget {
  const PhoneValidation({super.key});

  @override
  _PhoneValidationState createState() => _PhoneValidationState();
}

class _PhoneValidationState extends State<PhoneValidation> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _smsControllers = List.generate(4, (index) => TextEditingController());

  String _selectedCountryCode = "+213";
  bool _isLoading = false;

  Future<void> _proceedToStep2() async {
    // Validate all fields
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _smsControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email invalide')),
      );
      return;
    }

    // Validate password length
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
      );
      return;
    }

    final smsCode = _smsControllers.map((controller) => controller.text).join();

    setState(() {
      _isLoading = true;
    });

    try {
      print('Sending request to: http://localhost:3001/auth/register/step1');
      print('Data: ${{
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'phoneCode': _selectedCountryCode,
        'smsCode': smsCode,
      }}');

      final response = await ApiService.registerStep1(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: _phoneController.text.trim(),
        phoneCode: _selectedCountryCode,
        smsCode: smsCode,
      );

      setState(() {
        _isLoading = false;
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Step 1 successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Téléphone validé avec succès!')),
        );

        // Navigate to step 2 with email
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutYou(email: _emailController.text.trim()),
          ),
        );
      } else {
        final errorData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'] ?? 'Erreur est survenue - Code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion: Vérifiez que le serveur est démarré sur http://localhost:3001')),
      );
    }
  }

  void _onSmsCodeChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill with test data for easier testing
    _emailController.text = "imadferradji@gmail.com";
    _phoneController.text = "552050374";
    _smsControllers[0].text = "5";
    _smsControllers[1].text = "3";
    _smsControllers[2].text = "4";
    _smsControllers[3].text = "2";
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
                      // Your logo here
                      Container(
                        width: 140,
                        height: 60,
                        color: Colors.white,
                        child: const Center(child: Text('LOGO', style: TextStyle(fontWeight: FontWeight.bold))),
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

            const SizedBox(width: 20),

            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
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
                                  value: _selectedCountryCode,
                                  items: const [
                                    DropdownMenuItem(value: "+213", child: Text("+213")),
                                    DropdownMenuItem(value: "+1", child: Text("+1")),
                                    DropdownMenuItem(value: "+33", child: Text("+33")),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCountryCode = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "552050374",
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
                              child: TextField(
                                controller: _smsControllers[index],
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => _onSmsCodeChanged(value, index),
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
                          child: Text(
                            "Un SMS a été envoyé à votre numéro :\n $_selectedCountryCode ${_phoneController.text.isNotEmpty ? _phoneController.text : '552050374'}\n Valable jusqu'à 1h25",
                            style: const TextStyle(
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "imadferradji@gmail.com",
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.visibility_outlined),
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
                            child: _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                              onPressed: _proceedToStep2,
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