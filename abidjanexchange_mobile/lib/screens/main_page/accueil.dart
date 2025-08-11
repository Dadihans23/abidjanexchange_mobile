import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/widgets/animated_service_box.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  bool isDarkMode = false; // état pour le mode nuit
  bool isNotificationOn = false; // état pour la notification

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("lib/images/logo.jpg", width: 60, height: 50),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                        child: Icon(
                          isDarkMode
                              ? CupertinoIcons.moon_fill
                              : CupertinoIcons.moon,
                          size: 25,
                          color: isDarkMode ? Colors.amber : AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isNotificationOn = !isNotificationOn;
                          });
                        },
                        child: Icon(
                          isNotificationOn
                              ? Icons.notifications_active
                              : Icons.notifications_none,
                          size: 25,
                          color:
                              isNotificationOn ? Colors.red : AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),

              // GRID DES SERVICES
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5, // >1 = rectangle plus large que haut

                  children: [
                    SizedBox(
                      child: AnimatedServiceBox(
                        icon: CupertinoIcons.arrow_up_square,
                        title: "Achat/Vente",
                        onTap: () {
                          Navigator.pushNamed(context, '/achat_vente');
                        },
                      ),
                    ),
                    AnimatedServiceBox(
                      icon: CupertinoIcons.creditcard,
                      title: "Paiements",
                      onTap: () {
                        Navigator.pushNamed(context, '/paiements');
                      },
                    ),
                    AnimatedServiceBox(
                      icon: CupertinoIcons.bitcoin,
                      title: "Latoken Direct",
                      onTap: () {
                        Navigator.pushNamed(context, '/latoken');
                      },
                    ),
                    AnimatedServiceBox(
                      icon: CupertinoIcons.chart_bar_square,
                      title: "Binance Direct",
                      onTap: () {
                        Navigator.pushNamed(context, '/binance');
                      },
                    ),
                    AnimatedServiceBox(
                      icon: CupertinoIcons.creditcard_fill,
                      title: "Carte Virtuelle",
                      onTap: () {
                        Navigator.pushNamed(context, '/carte');
                      },
                    ),
                    AnimatedServiceBox(
                      icon: CupertinoIcons.person_2_fill,
                      title: "Mes Filleuls",
                      onTap: () {
                        Navigator.pushNamed(context, '/filleuls');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
