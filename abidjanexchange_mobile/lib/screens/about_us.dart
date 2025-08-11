import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Center(child: Text('À propos de nous', style: TextStyle(color: AppColors.textOnPrimary , fontWeight: FontWeight.bold))),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qui sommes-nous ?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Abidjanexchange est une plateforme innovante conçue pour faciliter les échanges et les transactions à Abidjan et au-delà. Fondée en 2023, notre mission est de connecter les utilisateurs à des opportunités économiques locales en offrant une interface simple et sécurisée. Nous mettons l\'accent sur la transparence et la facilité d\'utilisation pour tous nos clients.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Notre application',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'L\'application Abidjanexchange vous permet de gérer vos comptes, suivre vos transactions et découvrir de nouvelles offres en temps réel. Téléchargez-la dès aujourd\'hui et faites partie de notre communauté en croissance !',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}