import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/services/api_service.dart';
import 'package:abidjanexchange_mobile/screens/login.dart'; // Pour navigation vers Login
import 'dart:convert';


class RegisterScreen extends StatefulWidget {

  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
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

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await ApiService.register(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Inscription réussie ! Vérifiez votre email.',
              style: TextStyle(color: AppColors.textOnPrimary),
            ),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 4), // Durée de 4 secondes
          ),
        );
        // Attendre la fin de la SnackBar avant de naviguer
        await Future.delayed(Duration(seconds: 4));
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showCupertinoDialog(
          context,
          e.toString().replaceFirst('Exception: ', ''),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Noir profond
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo en haut
                Image.asset("lib/images/logo.jpg", width: 250, height: 200),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _firstNameController,
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
                      hintText: 'Prénom',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      errorStyle: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre prénom';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _lastNameController,
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
                      hintText: 'Nom',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      errorStyle: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: AppColors.textPrimary),
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      errorStyle: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
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
                      hintText: 'Numéro de téléphone (optionnel)',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      errorStyle: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      // Numéro de téléphone est optionnel, donc pas d'erreur si vide
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^\+?\d{8,15}$').hasMatch(value)) {
                          return 'Veuillez entrer un numéro de téléphone valide';
                        }
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
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      errorStyle: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? SpinKitCircle(color: AppColors.primary)
                    : GestureDetector(
                        onTap: _register,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Center(
                            child: Text(
                              "S'inscrire",
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
                    Text("Déjà un compte ?", style: TextStyle(color: AppColors.textPrimary)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Se connecter",
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
    );
  }
}