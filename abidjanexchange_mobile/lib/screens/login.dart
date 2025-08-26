import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/screens/register.dart'; // Pour la navigation vers l'inscription
import 'package:abidjanexchange_mobile/screens/password_request.dart'; // Pour "Mot de passe oublié"
import 'package:abidjanexchange_mobile/services/api_service.dart'; // Pour "Mot de passe oublié"


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscure = true;
  bool _isLoading = false;


  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur', style: TextStyle(color: AppColors.textPrimary)),
          content: Text(message, style: TextStyle(color: AppColors.textPrimary)),
          backgroundColor: AppColors.background,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }

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
              Image.asset("lib/images/logo.jpg", width: 200, height: 250),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary), // Blanc
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryDark), // Jaune foncé
                    ),
                    fillColor: AppColors.surface.withOpacity(0.1), // Blanc transparent
                    filled: true,
                    hintText: "Email",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary, // Gris bleu clair
                    ),
                    prefixIcon: Icon(Icons.email_sharp, color: AppColors.textSecondary),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: isObscure,
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
                    hintText: "Mot de passe",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(Icons.password, color: AppColors.textSecondary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                          builder: (context) => PasswordResetRequestScreen(),
                    ),                        
                    );
                      },
                      child: Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: AppColors.primary , fontSize: 12),
                      ),
                    ),
                   
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15 , horizontal: 25),
                child:
                _isLoading
                      ? SpinKitCircle(color: AppColors.primary)
                      : GestureDetector(
                  onTap: () async {
                    try {
                      // await ApiService.login(_emailController.text, _passwordController.text);
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (e) {
                      _showCupertinoDialog(context, e.toString().replaceFirst('Exception: ', ''));
                    }
                  } ,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: AppColors.primary, // Jaune orangé
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Connexion",
                        style: TextStyle(
                          color: AppColors.textOnPrimary, // Noir
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox( height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas de compte ? "),
                  SizedBox( width: 4,),
                  GestureDetector(
                    onTap: (){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),                        
                    );
                    },
                    child: Text("Inscription" , style:TextStyle(color: AppColors.primary , fontWeight: FontWeight.bold))),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}




