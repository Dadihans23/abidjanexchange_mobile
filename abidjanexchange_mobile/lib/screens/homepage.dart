
import 'package:abidjanexchange_mobile/screens/main_page/accueil.dart';
import 'package:abidjanexchange_mobile/screens/main_page/history.dart';
import 'package:abidjanexchange_mobile/screens/main_page/profil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:abidjanexchange_mobile/utils/colors.dart';
import 'package:abidjanexchange_mobile/screens/register.dart'; // Pour la navigation vers l'inscription
import 'package:abidjanexchange_mobile/screens/password_request.dart'; // Pour "Mot de passe oublié"
import 'package:abidjanexchange_mobile/services/api_service.dart'; // Pour "Mot de passe oublié"

import 'package:google_nav_bar/google_nav_bar.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
   const AccueilPage(),
    const HistoryPage(),
    const ProfilePage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            duration: const Duration(milliseconds: 700),
            haptic: true,
            backgroundColor: Colors.black,
            gap: 15,
            color: Colors.white,
            activeColor: Colors.white,
            iconSize: 30,
            tabBackgroundColor: AppColors.primary,
            padding: const EdgeInsets.all(10),
            tabs: const [
             GButton(
                icon: Icons.home,
                text: 'Accueil',
              ),
              GButton(
                icon: Icons.history,
                text: 'Historique',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
