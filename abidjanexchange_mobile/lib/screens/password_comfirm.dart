import 'package:abidjanexchange_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class PasswordResetConfirmScreen extends StatefulWidget {
  final String email;
  const PasswordResetConfirmScreen({Key? key, required this.email}) : super(key: key);

  @override
  _PasswordResetConfirmScreenState createState() => _PasswordResetConfirmScreenState();
}

class _PasswordResetConfirmScreenState extends State<PasswordResetConfirmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

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

  Future<void> _confirmReset() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showCupertinoDialog(context, 'Les mots de passe ne correspondent pas.');
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        print('Attempting to call ApiService.confirmPasswordReset with email: ${widget.email}, code: ${_codeController.text}');
        await ApiService.confirmPasswordReset(
          email: widget.email,
          code: _codeController.text,
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Mot de passe réinitialisé avec succès !',
              style: TextStyle(color: AppColors.textOnPrimary),
            ),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 4), // Harmonisé à 4 secondes
          ),
        );
        await Future.delayed(Duration(seconds: 4));
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error during password reset: $e');
        _showCupertinoDialog(
          context,
         "code de réinitialisation expiré "
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
                    child: Text(
                      "Un code de réinitialisation a été envoyé à votre adresse e-mail. Veuillez consulter votre boîte de réception (et vos spams si nécessaire).",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryDark),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        fillColor: AppColors.surface.withOpacity(0.1),
                        filled: true,
                        hintText: 'Code à 6 chiffres',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        prefixIcon: Icon(Icons.code, color: AppColors.textSecondary),
                        errorStyle: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le code';
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return 'Le code doit contenir exactement 6 chiffres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryDark),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        fillColor: AppColors.surface.withOpacity(0.1),
                        filled: true,
                        hintText: 'Nouveau mot de passe',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        prefixIcon: Icon(Icons.password, color: AppColors.textSecondary),
                        errorStyle: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un mot de passe';
                        }
                        if (value.length < 8) {
                          return 'Le mot de passe doit contenir au moins 8 caractères';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryDark),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.error),
                        ),
                        fillColor: AppColors.surface.withOpacity(0.1),
                        filled: true,
                        hintText: 'Confirmer le mot de passe',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        prefixIcon: Icon(Icons.password, color: AppColors.textSecondary),
                        errorStyle: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez confirmer le mot de passe';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? SpinKitCircle(color: AppColors.primary)
                      : GestureDetector(
                          onTap: _confirmReset,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Center(
                              child: Text(
                                "Réinitialiser",
                                style: TextStyle(
                                  color: AppColors.textOnPrimary,
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
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => Login()),
                          );
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
        ),
      ),
    );
  }
}