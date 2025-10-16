import 'package:flutter/material.dart';
import 'package:qanaty/core/theme/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../screens/api_service.dart';

class SoldeWidget extends StatefulWidget {
  final String dernier_modif;

  const SoldeWidget({
    super.key,
    required this.dernier_modif,
  });

  @override
  State<SoldeWidget> createState() => _SoldeWidgetState();
}

class _SoldeWidgetState extends State<SoldeWidget> {
  double _solde = 0.00;
  bool _isLoading = true;
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _userEmail = prefs.getString('userEmail') ?? '';
      });
      await _loadSolde();
    } catch (e) {
      print('❌ Error loading user data for solde: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSolde() async {
    try {
      if (_userEmail.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('🔄 Loading solde for: $_userEmail');

      final response = await ApiService.getUserSolde(_userEmail);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        setState(() {
          _solde = double.tryParse(responseData['solde']?.toString() ?? '0.00') ?? 0.00;
          _isLoading = false;
        });
        print('✅ Loaded solde: $_solde');
      } else {
        setState(() {
          _isLoading = false;
        });
        print('❌ Failed to load solde: ${responseData['message']}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('❌ Error loading solde: $e');
    }
  }

  // Public method to refresh solde from parent
  Future<void> refreshSolde() async {
    await _loadSolde();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 120,
      decoration: BoxDecoration(
        color: Appstyle.blanc,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appstyle.gris.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,6,5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                "${_solde.toStringAsFixed(2)} DA",
                style: Appstyle.textL_B.copyWith(color: Appstyle.blueF),
                textAlign: TextAlign.center,
              ),
            Text(
              "Solde",
              style: Appstyle.textM_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.dernier_modif,
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
            Text(
              "Dernier modification",
              style: Appstyle.textS_B.copyWith(color: Appstyle.noir),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}