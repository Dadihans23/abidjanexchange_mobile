import 'package:abidjanexchange_mobile/screens/achat_vente.dart';
import 'package:abidjanexchange_mobile/screens/change_password.dart';
import 'package:abidjanexchange_mobile/screens/homepage.dart';
import 'package:abidjanexchange_mobile/screens/intro.dart';
import 'package:abidjanexchange_mobile/screens/password_comfirm.dart';
import 'package:abidjanexchange_mobile/screens/password_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'services/api_service.dart';
import 'providers/auth_provider.dart';
import 'utils/colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // Déterminer la route initiale en fonction de l'état d'authentification

        final initialRoute = auth.user.accessToken != null ? '/intro' : '/intro';

        return MaterialApp(
          title: 'Abidjanexchange',
          theme: AppColors.theme,
          initialRoute: initialRoute,
          routes: {
            '/intro': (context) => const Intro(),
            '/login': (context) =>  Login(),
            '/register': (context) =>  RegisterScreen(),
            '/home': (context) => const MyHomePage(),
            '/password-reset': (context) =>  PasswordResetRequestScreen(),
            '/change-password': (context) => const ChangePasswordPage(),
            '/achat_vente': (context) => const AchatVenteScreen(),


          },
          onGenerateRoute: (settings) {
            if (settings.name == '/reset-password-confirm') {
              final email = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) => PasswordResetConfirmScreen(email: email),
              );
            }
            return null;
          },
        );
      },
    );
  }
}







// import 'package:abidjanexchange_mobile/screens/homepage.dart';
// import 'package:abidjanexchange_mobile/screens/intro.dart';
// import 'package:abidjanexchange_mobile/screens/password_comfirm.dart';
// import 'package:abidjanexchange_mobile/screens/password_request.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'screens/login.dart';
// import 'screens/register.dart';
// // import 'screens/password_reset_request.dart';
// // import 'screens/password_reset_confirm.dart';
// import 'services/api_service.dart';
// import 'utils/colors.dart';



// void main() {
//   runApp(const MyApp
//   ());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
// return MaterialApp(
//       title: 'Abidjanexchange',
//       theme: AppColors.theme, // Utiliser le thème défini dans colors.dart
//       initialRoute: '/intro',
//       routes: {
//         '/intro': (context) => Intro(),
//         '/login': (context) => Login(),
//         '/register': (context) => RegisterScreen(),
//         '/home': (context) => MyHomePage(),
//         '/password-reset': (context) => PasswordResetRequestScreen(),
//       },
//       onGenerateRoute: (settings) {
//     if (settings.name == '/reset-password-confirm') {
//         final email = settings.arguments as String;
//         return MaterialPageRoute(
//           builder: (context) => PasswordResetConfirmScreen(email: email),
//         );
//       }
//       return null;
//     },
//     );
//   }
// }