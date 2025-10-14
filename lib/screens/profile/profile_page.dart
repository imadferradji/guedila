import 'package:flutter/material.dart';
import 'package:qanaty/core/utilis/responsive.dart';
import 'package:qanaty/core/widget/acount_widget.dart';
import 'package:qanaty/core/widget/main_button.dart';
import 'package:qanaty/core/widget/periode_selector.dart';
import 'package:qanaty/core/widget/side_bar_widget.dart';

import '../../core/theme/app_style.dart';
import '../../core/widget/etat_widget.dart';
import '../../core/widget/facture_widget.dart';
import '../../core/widget/facture_widget_plus_imprimer.dart';
import '../../core/widget/search_field.dart';
import '../../core/widget/solde_widget.dart';
import '../../data/models/produit.dart';

class ProfilePage extends StatefulWidget {
  final String username="Oussama Bensbaa";
  final List<Produit> produits = [
    Produit(
      nom: "Bouteille 1.5 L",
      image: "assets/icons/eau_15l_icon.png",
      bouteillesParPalette: 100,
      prix: 22800,
      abrev: "1.5L", color: Appstyle.pie_creme,

    ), Produit(
      nom: "Bouteille 0.5 L",
      image: "assets/icons/eau_15l_icon.png",
      bouteillesParPalette: 100,
      prix: 22800,
      abrev: "0.5L", color: Appstyle.pie_orange,

    ),
    Produit(
      nom: "Bouteille 1 L",
      image: "assets/icons/eau_1l_icon.png",
      bouteillesParPalette: 120,
      prix: 18000,
      abrev: "1L", color: Appstyle.pie_blueC,
    ),
    Produit(
      nom: "Bouteille 2 L",
      image: "assets/icons/eau_2l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "2L", color: Appstyle.pie_blueF,
    ),
    Produit(
      nom: "Bouteille 0.33 Cl",
      image: "assets/icons/eau_33l_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.33L", color: Appstyle.pie_move,
    ),
    Produit(
      nom: "Bouteille 0.33 L Sport",
      image: "assets/icons/eau_33l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.33L S", color: Appstyle.pie_grena,
    ),
    Produit(
      nom: "Bouteille 0.5 L Sport",
      image: "assets/icons/eau_05l_sport_icon.png",
      bouteillesParPalette: 80,
      prix: 25000,
      abrev: "0.5L S", color: Appstyle.pie_vert,
    ),
  ];
  ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  final TextEditingController _controller = TextEditingController();

  // Move controllers and variables inside the class
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _restrictionTime = "9:00";
  bool _isTimeRestrictionEnabled = true;

  // Track selected button
  int _selectedButtonIndex = 0;

  // Notification settings
  bool _issueActivityEnabled = true;
  bool _trackingActivityEnabled = false;
  bool _newCommentsEnabled = false;

  // Confidentiality settings
  bool _enableDataEncryption = true;
  bool _enableTwoFactorAuth = false;
  bool _enableActivityLogging = true;

  // Button titles (removed virement)
  final List<String> _buttonTitles = ['Compte', 'Notification', 'Confidentiality'];
  final List<String> _buttonIcons = [
    "assets/icons/profile_icon.png",
    "assets/icons/notifications_icon.png",
    "assets/icons/document_icon.png"
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with some default values
    _nameController.text = "Oussama";
    _familyNameController.text = "Bensbaa";
    _emailController.text = "oussama@example.com";
    _dobController.text = "15/03/1990";
    _companyController.text = "Qanaty Company";
  }

  // Move methods inside the class
  void _showEditDialog(String fieldName, TextEditingController controller) {
    final textEditingController = TextEditingController(text: controller.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $fieldName'),
        content: TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter $fieldName',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                controller.text = textEditingController.text; // Update with new value
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      print('Name: ${_nameController.text}');
      print('Family Name: ${_familyNameController.text}');
      print('Email: ${_emailController.text}');
      print('Date of Birth: ${_dobController.text}');
      print('Company Name: ${_companyController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _familyNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _companyController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.blueSC,
      body: LayoutBuilder(
        builder:(context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          const minWidth = 1200.0;
          const minHeight = 900.0;

          final adjustedWidth = screenWidth < minWidth ? minWidth : screenWidth;
          final adjustedHeight = screenHeight < minHeight ? minHeight : screenHeight;
          final paddingV=  adjustedHeight*0.03;
          final paddingH=  adjustedWidth*0.03;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: minWidth,
                  minHeight: minHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: adjustedWidth,
                    height: adjustedHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Side bar
                        Container(
                            width:Responsive.sidebarWidth(adjustedWidth),
                            height:Responsive.sidebarHeight(adjustedHeight),
                            child: SideBarWidget()
                        ),
                        SizedBox(width: paddingH,),
                        Expanded(
                          child: Column(
                              children: [
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    IconButton(
                                      icon: Image.asset(
                                        "assets/icons/notifications_icon.png",
                                        width: Responsive.notificationSize(adjustedWidth),
                                        height: Responsive.notificationSize(adjustedWidth),
                                        fit: BoxFit.contain,
                                      ),
                                      onPressed: () {
                                      },
                                    ),
                                    AccountWidget(name: "Oussama Bensbaa", imageUrl: "assets/images/support.png"),
                                    SizedBox(width: 16,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Profil", style:Appstyle.textXL_B.copyWith(color: Appstyle.noir)),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    // Left side menu buttons - Updated style
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 290,
                                          height: 740,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 30),
                                                // Generate buttons dynamically with new style
                                                for (int i = 0; i < _buttonTitles.length; i++)
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                    child: _buildSidebarStyleButton(
                                                      title: _buttonTitles[i],
                                                      iconPath: _buttonIcons[i],
                                                      isSelected: _selectedButtonIndex == i,
                                                      onTap: () {
                                                        setState(() {
                                                          _selectedButtonIndex = i;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    // Right side content based on selected button
                                    _selectedButtonIndex == 0
                                        ? _buildProfileForm()
                                        : _selectedButtonIndex == 1
                                        ? _buildNotificationSettings()
                                        : _buildConfidentialityContent(),
                                  ],
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Sidebar style button widget
  Widget _buildSidebarStyleButton({
    required String title,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Appstyle.blueC : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: Appstyle.blueC, width: 2) : null,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: isSelected
                    ? Appstyle.textL_B.copyWith(color: Colors.white)
                    : Appstyle.textL_B.copyWith(color: Colors.grey.shade700),
              ),
              Spacer(),
              if (isSelected)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Form Widget
  Widget _buildProfileForm() {
    return Column(
      children: [
        SizedBox(
          width: 600,
          height: 740,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/profile.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field - Read Only
                      _buildReadOnlyField(
                        label: 'Name',
                        value: _nameController.text,
                        icon: Icons.person,
                        onEdit: () => _showEditDialog('Name', _nameController),
                      ),
                      SizedBox(height: 16),

                      // Family Name Field - Read Only
                      _buildReadOnlyField(
                        label: 'Family Name',
                        value: _familyNameController.text,
                        icon: Icons.family_restroom,
                        onEdit: () => _showEditDialog('Family Name', _familyNameController),
                      ),
                      SizedBox(height: 16),

                      // Email Field - Read Only
                      _buildReadOnlyField(
                        label: 'Email',
                        value: _emailController.text,
                        icon: Icons.email,
                        onEdit: () => _showEditDialog('Email', _emailController),
                      ),
                      SizedBox(height: 16),

                      // Date of Birth Field - Read Only
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade50,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today, color: Colors.grey.shade600),
                          title: Text(
                            _dobController.text.isEmpty ? 'Date of Birth' : _dobController.text,
                            style: _dobController.text.isEmpty
                                ? Appstyle.textM.copyWith(color: Colors.grey.shade500)
                                : Appstyle.textM,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _selectDate(context),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Company Name Field - Read Only
                      _buildReadOnlyField(
                        label: 'Company Name',
                        value: _companyController.text,
                        icon: Icons.business,
                        onEdit: () => _showEditDialog('Company Name', _companyController),
                      ),
                      SizedBox(height: 24),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Save Profile'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to create read-only fields with edit button
  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey.shade600),
        title: Text(
          value.isEmpty ? label : value,
          style: value.isEmpty
              ? Appstyle.textM.copyWith(color: Colors.grey.shade500)
              : Appstyle.textM,
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: onEdit,
        ),
      ),
    );
  }

  // Notification Settings Widget
  Widget _buildNotificationSettings() {
    return Column(
      children: [
        SizedBox(
          width: 600,
          height: 740,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Notification Settings",
                    style: Appstyle.textXL_B,
                  ),
                  SizedBox(height: 30),

                  // Issue Activity Notification
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Issue Activity",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Send me email notifications for issue activity",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _issueActivityEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _issueActivityEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // Tracking Activity Notification
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tracking Activity",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Send me notifications when someone's tracked time in tasks",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _trackingActivityEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _trackingActivityEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // New Comments Notification
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Comments",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Send me notifications for new comments on my tasks",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _newCommentsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _newCommentsEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // Time Restriction
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quiet Hours",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Don't send me notifications after 9:00 PM",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _isTimeRestrictionEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _isTimeRestrictionEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Save Settings Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Save notification settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Notification settings saved successfully!')),
                        );
                      },
                      child: Text('Save Settings'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Confidentiality Content Widget
  Widget _buildConfidentialityContent() {
    return Column(
      children: [
        SizedBox(
          width: 600,
          height: 740,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Confidentiality Settings",
                    style: Appstyle.textXL_B,
                  ),
                  SizedBox(height: 30),

                  // Data Encryption Option
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Data Encryption",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Enable end-to-end encryption for all your data to ensure maximum security and privacy",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _enableDataEncryption,
                          onChanged: (bool value) {
                            setState(() {
                              _enableDataEncryption = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // Two-Factor Authentication Option
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Two-Factor Authentication",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Add an extra layer of security to your account by requiring a verification code",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _enableTwoFactorAuth,
                          onChanged: (bool value) {
                            setState(() {
                              _enableTwoFactorAuth = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // Activity Logging Option
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Activity Logging",
                                style: Appstyle.textL_B,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Keep track of all account activities and access logs for security monitoring",
                                style: Appstyle.textM.copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Switch(
                          value: _enableActivityLogging,
                          onChanged: (bool value) {
                            setState(() {
                              _enableActivityLogging = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Save Settings Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Save confidentiality settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Confidentiality settings saved successfully!')),
                        );
                      },
                      child: Text('Save Settings'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}