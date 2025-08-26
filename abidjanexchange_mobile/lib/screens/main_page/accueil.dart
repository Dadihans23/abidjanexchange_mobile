import 'package:abidjanexchange_mobile/widgets/custom_header_appbar.dart';
import 'package:abidjanexchange_mobile/widgets/recenct_activities.dart';
import 'package:abidjanexchange_mobile/widgets/serviceRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/widgets/animated_service_box.dart';
import 'dart:ui'; // Pour ImageFilter.blur


class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  bool isDarkMode = false; // état pour le mode nuit
  bool isNotificationOn = false; // état pour la notification


  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;


  @override
  Widget build(BuildContext context) {

        final width = screenWidth(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
              CustomAppHeader(
                isDarkMode: isDarkMode,
                isNotificationOn: isNotificationOn,
                onToggleDarkMode: () {
                  // setState(() => isDarkMode = !isDarkMode);
                },
                onToggleNotification: () {
                  setState(() => isNotificationOn = !isNotificationOn);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Image.asset("lib/images/logo.jpg", width: 30, height: 25),
                        Text("BTC" ,style : TextStyle(
                          fontSize: 16,
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1
                
                        ),)
                      ],
                    ) ,
                    SizedBox(width: 8,) ,
                    Text("32.250.000 CFA" ,style : TextStyle(
                          fontSize: 16,
                          color: AppColors.successaccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1
                        ),),
                    SizedBox(width: 8,) ,
                    Text("+2.54 %" ,style : TextStyle(
                          fontSize: 13,
                          color: AppColors.success,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1
                
                        ),)
                
                  ],
                ),
              ) ,
              Row(
                  children: [
                    _buildStatCard(context, Icons.calendar_today, "Aujourd'hui", "+2.54 %", Colors.blue, AppColors.success),
                    _buildStatCard(context, Icons.monetization_on, "Volume 24h", "2.4M CFA", Colors.blue, Colors.blue),
                    _buildStatCard(context, Icons.swap_horiz, "Transactions", "156", Colors.blue, Colors.indigo),
                  ],
                ),
                Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final isSmallScreen = screenWidth < 360;
                    return Text(
                            "Services principaux",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 17 : 19,
                              color: AppColors.background,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1,
                            ),
                          );
                            },
                          ),
                          const SizedBox(height: 20),

                        ServiceRow(
                        title: "Acheter des cryptos",
                        subtitle: "Acheter Bitcoin, Ethereum et plus avec Orange Money, Wave",
                        tags: ["Frais des 1.2%", "instantané"],
                        tagColors: [Colors.green, Colors.blueAccent],
                        leadingIcon: Icons.import_contacts,
                        leadingIconColor: Colors.blue,
                        trailingIcon: Icons.arrow_right,
                        trailingIconColor: Colors.blue,
                        onTap: () {
                          // Action à faire au clic
                          Navigator.pushNamed(context, '/achat_vente');

                        },
                      ),
                      SizedBox(height: 10,) ,
                        ServiceRow(
                        title: "Vendre des cryptos",
                        subtitle: "Convertissez vos cryptos en CFA sur mon Mobile Money",
                        tags: ["Meilleurs taux", "Securisé"],
                        tagColors: [Colors.orange, Colors.pinkAccent],
                        leadingIcon: Icons.import_contacts,
                        leadingIconColor: Colors.blue,
                        trailingIcon: Icons.arrow_right,
                        trailingIconColor: Colors.blue,
                        onTap: () {
                          Navigator.pushNamed(context, '/achat_vente');
                        }
                      ) ,
                       SizedBox(height: 10,) ,
                        ServiceRow(
                        title: "Transfert internationnal",
                        subtitle: "Envoyez de l'argent vers d'autres pays via crypto",
                        tags: ["Rapide", "Economique"],
                        tagColors: [Colors.green , Colors.indigo],
                        leadingIcon: Icons.import_contacts,
                        leadingIconColor: Colors.blue,
                        trailingIcon: Icons.arrow_right,
                        trailingIconColor: Colors.blue,
                        onTap: () {
                          // Navigator.pushNamed(context, '/achat_vente');
                        }
                      ) ,
                          const SizedBox(height: 20),

                      Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                            "Activité recentes",
                            style: TextStyle(
                              fontSize:   17 ,
                              color: AppColors.background,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1,
                            ),
                          ),
                      Text("Voir tout" , style: TextStyle(
                              fontSize:   15 ,
                              color: AppColors.background,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 0.1,
                            ),)
                    ],
                  ),
                  SizedBox(height: 20,) ,


                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white , 
                      borderRadius: BorderRadius.circular(07)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.abc,
                              color: Colors.red,
                              size: width * 0.08,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Achat BTC" ,style: TextStyle(
                                fontSize:   15 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),),
                              Text("Il y a 2h" ,style: TextStyle(
                                fontSize:   14 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.1,
                              ),)
                            ],
                          )
                        ],
                       ) ,
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("-250000 CFA" ,style: TextStyle(
                                fontSize:   15 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),),
                              Text("+0.000077 BTC" ,style: TextStyle(
                                fontSize:   14 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.1,
                              ),)
                        ],
                       )
                      ],
                    ),
                  ),




                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white , 
                      borderRadius: BorderRadius.circular(07)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.abc,
                              color: Colors.red,
                              size: width * 0.08,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vente ETH" ,style: TextStyle(
                                fontSize:   15 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),),
                              Text("Hier" ,style: TextStyle(
                                fontSize:   14 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.1,
                              ),)
                            ],
                          )
                        ],
                       ) ,
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("50.000 CFA" ,style: TextStyle(
                                fontSize:   15 ,
                                color: AppColors.background,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),),
                              Text("terminé" ,style: TextStyle(
                                fontSize:   14 ,
                                color: AppColors.successaccent,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1,
                              ),)
                        ],
                       )
                      ],
                    ),
                  )
                  

                  


                  
                ],
              ),
            )




                  
                ],
              ),
            ),
            
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  
Widget _buildStatCard(BuildContext context, IconData icon, String title, String value, Color iconColor, Color valueColor) {
  double screenWidth = MediaQuery.of(context).size.width;
  double iconSize = screenWidth * 0.07; // proportionnel à la largeur
  double titleSize = screenWidth * 0.04;
  double valueSize = screenWidth * 0.05;

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(08),
        color: Colors.white,

      ),
      margin: EdgeInsets.all(02),
      padding: EdgeInsets.all(screenWidth * 0.04), // padding responsive
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          SizedBox(height: screenWidth * 0.03),
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              color: valueColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    ),
  );
}

}
