import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomAppHeader extends StatelessWidget {
  final bool isDarkMode;
  final bool isNotificationOn;
  final VoidCallback onToggleDarkMode;
  final VoidCallback onToggleNotification;

  const CustomAppHeader({
    super.key,
    required this.isDarkMode,
    required this.isNotificationOn,
    required this.onToggleDarkMode,
    required this.onToggleNotification,
  });

  Widget _glassIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // effet verre
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.1,
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigoAccent,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Titre
          Row(
            children: [
              Image.asset("lib/images/logo.jpg", width: 30, height: 25),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "AbidjanExchange",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Votre passerelle de crypto",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),

          // Icônes actions
          Row(
            children: [
              _glassIcon(
                icon: isDarkMode
                    ? CupertinoIcons.moon_fill
                    : CupertinoIcons.moon,
                color: isDarkMode ? Colors.amber : AppColors.primary,
                onTap: onToggleDarkMode,
              ),
              const SizedBox(width: 10),
              _glassIcon(
                icon: isNotificationOn
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                color: isNotificationOn ? Colors.red : AppColors.primary,
                onTap: onToggleNotification,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
