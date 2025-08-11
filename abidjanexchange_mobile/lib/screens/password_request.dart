import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class PasswordResetRequestScreen extends StatefulWidget {
  @override
  _PasswordResetRequestScreenState createState() =>
      _PasswordResetRequestScreenState();
}

class _PasswordResetRequestScreenState extends State<PasswordResetRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  // Future<void> _requestReset() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //       _errorMessage = null;
  //     });
  //     try {
  //       await ApiService.requestPasswordReset(_emailController.text);
  //       print('ooo') ;
  //       // Navigator.pushNamed(context, '/reset-password-confirm');
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   SnackBar(
  //       //     content: Text(
  //       //       'Code envoyé ! Vérifiez votre email.',
  //       //       style: TextStyle(color: AppColors.textOnPrimary),
  //       //     ),
  //       //     backgroundColor: AppColors.success,
  //       //   ),
  //       // );
  //     } catch (e) {
  //       setState(() {
  //         _errorMessage = e.toString().replaceFirst('Exception: ', '');
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  void _showCupertinoDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Alerte", style: TextStyle(color: AppColors.textPrimary)),
          content: Text(message, style: TextStyle(color: AppColors.textSecondary)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Okay", style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Noir profond
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo en haut
              Image.asset("lib/images/logo.jpg", width: 200, height: 250),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(color: AppColors.textPrimary),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary), // Blanc
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryDark), // Jaune foncé
                    ),
                    fillColor: AppColors.surface.withOpacity(0.1), // Blanc transparent
                    filled: true,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary, // Gris bleu clair
                    ),
                    prefixIcon: Icon(Icons.email_sharp, color: AppColors.textSecondary),
                  ),
                  
                ),
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: AppColors.error), // Rouge pour erreurs
                ),
              const SizedBox(height: 16),
              _isLoading
                  ? SpinKitCircle(color: AppColors.primary) // Jaune orangé
                  : GestureDetector(
                        onTap: () async {
                        try {
                          await ApiService.requestPasswordReset(_emailController.text);
                          Navigator.pushReplacementNamed(context, '/reset-password-confirm' ,arguments: _emailController.text,
);
                        } catch (e) {
                          _showCupertinoDialog(context, e.toString().replaceFirst('Exception: ', ''));
                        }
                      } ,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: AppColors.primary, // Jaune orangé
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            "Envoyer le code",
                            style: TextStyle(
                              color: AppColors.textOnPrimary, // Noir
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Retour à la ", style: TextStyle(color: AppColors.textPrimary)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Connexion",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}