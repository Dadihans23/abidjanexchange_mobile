class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? accessToken;
  final String? refreshToken;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
  });

  // Factory pour créer un User à partir d'un JSON (par exemple, après une réponse API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      accessToken: json['access'] as String?,
      refreshToken: json['refresh'] as String?,
    );
  }

  // Méthode pour convertir un User en JSON (utile pour le stockage local si nécessaire)
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'access': accessToken,
      'refresh': refreshToken,
    };
  }

  // User vide pour l'initialisation
  static User get empty => User();
}