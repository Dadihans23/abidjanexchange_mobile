// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../utils/constant.dart';

// class ApiService {
//   static const _storage = FlutterSecureStorage();

//   // Inscription
//   static Future<void> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     String? phoneNumber,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}auth/register/'),
//         headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             },  
//         body: jsonEncode({
//         'first_name': firstName,
//         'last_name': lastName,
//         'email': email,
//         'phone_number': phoneNumber ?? '',
//         'password': password,
//       }),

//     );
//     if (response.statusCode != 201) {
//       final error = jsonDecode(response.body)['message'] ?? 'Erreur d\'inscription.';
//       throw Exception(error);
//     }
//   }

//   // Activation
//   static Future<void> activateAccount(String uidb64, String token) async {
//     final response = await http.get(
//       Uri.parse('${Constants.baseUrl}auth/activate/$uidb64/$token/'),
//     );
//     if (response.statusCode != 200) {
//       throw Exception('Lien d\'activation invalide.');
//     }
//   }

//   // Connexion
//   static Future<void> login(String email, String password) async {
//     print('Début login avec $email');
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}auth/login/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );
//     if (response.statusCode == 200) {
//       print('bien ') ;
//       final data = jsonDecode(response.body);
//       await _storage.write(key: 'refresh_token', value: data['refresh']);
//       await _storage.write(key: 'access_token', value: data['access']);
//     } else {
//       print("hoo") ;
//       final error = jsonDecode(response.body)['message'] ?? 'Erreur de connexion.';
//       throw Exception(error);
//     }
//   }

//   // Demande de réinitialisation
//   static Future<void> requestPasswordReset(String email) async {
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}auth/password-reset/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email}),
//     );
//     if (response.statusCode != 200) {
//       final error = jsonDecode(response.body)['message'] ?? 'Erreur lors de la demande.';
//       print(error) ;
//       throw Exception(error);
//     }
//   }

//   // Confirmation de réinitialisation
//   static Future<void> confirmPasswordReset({
//     required String email,
//     required String code,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}auth/reset-password/confirm/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': email,
//         'code': code,
//         'password': password,
//       }),
//     );
//     if (response.statusCode != 200) {
//       final error = jsonDecode(response.body)['message'] ?? 'Erreur lors de la réinitialisation.';
//       throw Exception(error);
//     }
//   }
// }



import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constant.dart';



class ApiService {
  static const _storage = FlutterSecureStorage();

  // Headers communs pour toutes les requêtes
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // Inscription
  static Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}auth/register/'),
      headers: _headers,
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber ?? '',
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      final errorData = jsonDecode(utf8.decode(response.bodyBytes));
      final error = errorData['message'] ?? 'Erreur d\'inscription.';
      throw Exception(error);
    }
  }

  // Activation
  static Future<void> activateAccount(String uidb64, String token) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}auth/activate/$uidb64/$token/'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      final errorData = jsonDecode(utf8.decode(response.bodyBytes));
      final error = errorData['message'] ?? 'Lien d\'activation invalide.';
      throw Exception(error);
    }
  }

  // Connexion
  static Future<void> login(String email, String password) async {
    print('Début login avec $email');
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}auth/login/'),
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      print('bien');
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      await _storage.write(key: 'refresh_token', value: data['refresh']);
      await _storage.write(key: 'access_token', value: data['access']);
    } else {
      print('hoo');
      final errorData = jsonDecode(utf8.decode(response.bodyBytes));
      final error = errorData['message'] ?? 'Erreur de connexion.';
      throw Exception(error);
    }
  }

  // Demande de réinitialisation
  static Future<void> requestPasswordReset(String email) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}auth/password-reset/'),
      headers: _headers,
      body: jsonEncode({'email': email}),
    );
    if (response.statusCode != 200) {
      final errorData = jsonDecode(utf8.decode(response.bodyBytes));
      final error = errorData['message'] ?? 'Erreur lors de la demande.';
      print(error);
      throw Exception(error);
    }
  }

  // Confirmation de réinitialisation
  static Future<void> confirmPasswordReset({
    required String email,
    required String code,
    required String password,
  }) async {
    print('Début login avec $email');
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}auth/reset-password/confirm/'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'code': code,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      
      final errorData = jsonDecode(utf8.decode(response.bodyBytes));
      final error = errorData['message'] ?? 'Erreur lors de la réinitialisation.';
      throw Exception(error);
    }
  }

 
  static Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) {
        return {
          'success': false,
          'message': 'Utilisateur non connecté.',
          'statusCode': 401,
        };
      }

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}auth/change-password/'),
        headers: {
          ..._headers,
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': jsonDecode(utf8.decode(response.bodyBytes))['message'],
          'statusCode': response.statusCode,
        };
      } else {
        final errorData = jsonDecode(utf8.decode(response.bodyBytes));
        return {
          'success': false,
          'message': errorData['message'] ?? 'Erreur lors du changement de mot de passe.',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur. Vérifiez votre connexion internet.',
        'statusCode': 0,
      };
    }
  }

}