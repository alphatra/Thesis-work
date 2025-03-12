import 'user.dart';

class AuthResult {
  final String token;
  final User user;

  const AuthResult({
    required this.token,
    required this.user,
  });
}