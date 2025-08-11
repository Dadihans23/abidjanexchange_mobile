




import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:abidjanexchange_mobile/widgets/button.dart';
import 'package:abidjanexchange_mobile/screens/login.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});
 // height: MediaQuery.of(context).size.height / 6.5,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Noir profond
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  Image.asset("lib/images/logo.jpg", width: 350, height: 350),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: const Text(
                      "Achetez et vendez vos cryptomonnaies préférées en toute simplicité, sécurité et rapidité. Gérez vos transactions depuis un seul espace, où que vous soyez",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary, // Gris bleu clair
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.4,
                        decorationStyle: TextDecorationStyle.double,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
           Expanded(
            flex: 1,
             child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30 , horizontal: 10),
                  child: Button(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                      builder: (context) => Login(),
                    ),
                    );
                  },
                  buttonText: "Démarrer",
                ),
            
                )
           ),
        ],
      )
    );
  }
}








