import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../services/api_service.dart';


class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User _user = User.empty;
  bool _isLoading = false;
  String? _errorMessage;

  User get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Initialiser l'utilisateur à partir du stockage sécurisé
  Future<void> initialize() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (accessToken != null && refreshToken != null) {
      _user = User(accessToken: accessToken, refreshToken: refreshToken);
      notifyListeners();
    }
  }

  // Connexion
  Future<void> login(String email, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await ApiService.login(email, password);
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');
      _user = User(
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    _user = User.empty;
    notifyListeners();
  }

  // Mettre à jour l'état interne
  void setState(void Function() callback) {
    callback();
    notifyListeners();
  }
}