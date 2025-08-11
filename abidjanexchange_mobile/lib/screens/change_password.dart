import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/services/api_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOldObscure = true;
  bool _isNewObscure = true;
  bool _isConfirmObscure = true;

  void _showCupertinoDialog(BuildContext context, String message, {bool isSuccess = false}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(isSuccess ? 'Succès' : 'Erreur', style: TextStyle(color: AppColors.textPrimary)),
          content: Text(message, style: TextStyle(color: AppColors.textSecondary)),
          actions: [
            CupertinoDialogAction(
              child: Text('OK', style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.pop(context); // Retour à la page précédente
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      final result = await ApiService.changePassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (result['success']) {
        _showCupertinoDialog(context, result['message'], isSuccess: true);
      } else {
        setState(() {
          _errorMessage = result['message'];
        });
        _showCupertinoDialog(context, _errorMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Réinitialisation',
            style: TextStyle(color: AppColors.textOnPrimary, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Changer le mot de passe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _oldPasswordController,
                          style: TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryDark),
                            ),
                            fillColor: AppColors.surface.withOpacity(0.1),
                            filled: true,
                            hintText: "Ancien mot de passe",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            prefixIcon: Icon(Icons.lock, color: AppColors.textSecondary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isOldObscure ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isOldObscure = !_isOldObscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _isOldObscure,
                          validator: (value) => value!.isEmpty ? 'Veuillez entrer votre ancien mot de passe.' : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _newPasswordController,
                          style: TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryDark),
                            ),
                            fillColor: AppColors.surface.withOpacity(0.1),
                            filled: true,
                            hintText: "Nouveau mot de passe",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textSecondary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isNewObscure ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNewObscure = !_isNewObscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _isNewObscure,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return 'Le mot de passe doit contenir au moins 8 caractères.';
                            }
                            if (value == _oldPasswordController.text) {
                              return 'Le nouveau mot de passe doit être différent de l\'ancien.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          style: TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryDark),
                            ),
                            fillColor: AppColors.surface.withOpacity(0.1),
                            filled: true,
                            hintText: "Confirmer le nouveau mot de passe",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            prefixIcon: Icon(Icons.lock_clock, color: AppColors.textSecondary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmObscure ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmObscure = !_isConfirmObscure;
                                });
                              },
                            ),
                          ),
                          obscureText: _isConfirmObscure,
                          validator: (value) {
                            if (value != _newPasswordController.text) {
                              return 'Les mots de passe ne correspondent pas.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: _isLoading
                              ? SpinKitCircle(color: AppColors.primary)
                              : GestureDetector(
                                  onTap: _changePassword,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Changer le mot de passe",
                                        style: TextStyle(
                                          color: AppColors.textOnPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}