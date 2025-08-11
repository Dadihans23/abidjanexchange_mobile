import 'package:flutter/material.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  // Fonction pour lancer un lien (email ou WhatsApp)


  @override
  Widget build(BuildContext context) {


   Future<void> openWhatsApp({required String phone, String? message}) async {
    final Uri uri = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message ?? '')}");
    
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d’ouvrir WhatsApp');
    }
  }


    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Center(child: Text('Nous contacter', style: TextStyle(color: AppColors.textOnPrimary , fontWeight: FontWeight.bold))),
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("lib/images/logo.jpg", width: 350, height: 300),
              Text("Nous sommes là pour vous aider à chaque étape. Si vous rencontrez des difficultés lors de l’utilisation de notre application ou si vous avez des questions concernant nos services, n’hésitez pas à nous contacter. ",
                style: TextStyle(color: AppColors.textPrimary , fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 30),
              Text(
                'Contactez-nous',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.email, color: AppColors.primary),
                title: Text(
                  'Email: support@abidjanexchange.com',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
             
              ListTile(
                leading: Icon(Icons.location_on, color: AppColors.primary),
                title: Text(
                  'Adresse: Abidjan, Cocody Riviera Jules Vernes',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                onTap: () {}, // À remplacer par une carte si besoin
              ),
               Center(
                 child: GestureDetector(
                    onTap: () {
                    openWhatsApp(
                    phone: "2250700000000", // numéro au format international (sans +)
                    message: "Bonjour, j'aimerais plus d'infos !",
                  );
                  },
                   child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("Via whatsapp dirrectement " ,style: TextStyle(color: AppColors.background , fontSize: 19 , fontWeight: FontWeight.bold),),
                               ),
                 ),
               )
             
            ],
          ),
        ),
      ),
    );
  }
}



//  ListTile(
//               leading: Icon(Icons.phone, color: AppColors.primary),
//               title: Text(
//                 'WhatsApp: +225 07 12 34 56 78',
//                 style: TextStyle(color: AppColors.textSecondary),
//               ),
//               onTap: () => _launchURL('https://wa.me/2250712345678'),
//             ),