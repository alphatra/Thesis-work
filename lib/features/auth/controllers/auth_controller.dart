import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/auth_service.dart';
import '../models/user.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthController extends StateNotifier<User?> {
  final AuthService _authService;

  AuthController(this._authService) : super(null);

  Future<void> login(String email, String password) async {
    try {
      developer.log('Rozpoczynam proces logowania dla: $email');
      final response = await _authService.login(email, password);
      developer.log('Otrzymano odpowiedź z serwera: $response');
      
      final user = User(
        id: response['user']['id'],
        name: response['user']['name'],
        email: response['user']['email'],
        role: response['user']['role'],
        token: response['token'],
      );
      
      developer.log('Utworzono obiekt użytkownika: ${user.toString()}');
      state = user;
      developer.log('Stan został zaktualizowany');
    } catch (e, stackTrace) {
      developer.log(
        'Błąd podczas logowania',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException('Błąd podczas logowania: ${e.toString()}');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      developer.log('Rozpoczynam proces rejestracji dla: $email');
      await _authService.register(name, email, password);
      await login(email, password);
    } catch (e, stackTrace) {
      developer.log(
        'Błąd podczas rejestracji',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException('Błąd podczas rejestracji: ${e.toString()}');
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      developer.log('Rozpoczynam walidację tokenu');
      final response = await _authService.validateToken(token);
      return response['valid'] as bool;
    } catch (e, stackTrace) {
      developer.log(
        'Błąd podczas walidacji tokenu',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  void logout() {
    developer.log('Wylogowywanie użytkownika');
    state = null;
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
}); 