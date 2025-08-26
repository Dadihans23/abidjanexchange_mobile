import 'package:flutter/material.dart';

class AppColors {
  // Couleurs primaires
  static const Color primary = Color(0xFFFFC107); // Jaune orangé vibrant (inspiré du logo)
  static const Color primaryDark = Color(0xFFFFA000); // Jaune orangé foncé
  static const Color primaryLight = Color(0xFFFFE082); // Jaune orangé clair

  // Couleurs secondaires
  static const Color secondary = Color(0xFFFFFFFF); // Blanc pour contraste
  static const Color secondaryDark = Color(0xFFE0E0E0); // Gris clair pour subtilité

  // Couleurs de fond
  static const Color background = Colors.black; // Noir profond
  static const Color surface = Color.fromARGB(255, 211, 211, 211); // Blanc pur

  // Couleurs pour le texte
  static const Color textPrimary = Color(0xFFFFFFFF); // Blanc pour texte sur fond noir
  static const Color textSecondary = Color(0xFFB0BEC5); // Gris bleu clair pour texte secondaire
  static const Color textOnPrimary = Color(0xFF212121); // Noir pour texte sur fond jaune

  // Couleurs utilitaires
  static const Color error = Color(0xFFEF5350); // Rouge corail pour erreurs
  static const Color success = Color(0xFF66BB6A); // Vert émeraude pour succès
    static const Color successaccent= Color.fromARGB(255, 60, 170, 67); // Vert émeraude pour succès

  static const Color warning = Color(0xFFFFB300); // Jaune foncé pour avertissements

  // Thème Material
  static ThemeData get theme => ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.dark(
          primary: primary,
          secondary: secondary,
          background: background,
          surface: surface,
          error: error,
        ),
        scaffoldBackgroundColor: background,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: textPrimary),
          bodyMedium: TextStyle(color: textSecondary),
          labelLarge: TextStyle(color: textOnPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: textOnPrimary,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: secondary, // Blanc pour les TextButton
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryDark, width: 2),
          ),
          labelStyle: TextStyle(color: textSecondary),
          filled: true,
          fillColor: surface.withOpacity(0.1),
        ),
      );
}