import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:8000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      developer.log('Próba logowania dla: $email');
      developer.log('URL: $baseUrl/auth/login');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      developer.log('Kod odpowiedzi: ${response.statusCode}');
      developer.log('Treść odpowiedzi: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        developer.log('Zdekodowana odpowiedź: $decodedResponse');
        return decodedResponse;
      } else {
        throw Exception('Błąd logowania (${response.statusCode}): ${response.body}');
      }
    } catch (e, stackTrace) {
      developer.log('Wyjątek podczas logowania:', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      developer.log('Próba rejestracji dla: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      developer.log('Kod odpowiedzi: ${response.statusCode}');
      developer.log('Treść odpowiedzi: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Błąd rejestracji (${response.statusCode}): ${response.body}');
      }
    } catch (e, stackTrace) {
      developer.log('Wyjątek podczas rejestracji:', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> validateToken(String token) async {
    try {
      developer.log('Próba walidacji tokenu');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/validate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
        }),
      );

      developer.log('Kod odpowiedzi: ${response.statusCode}');
      developer.log('Treść odpowiedzi: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Błąd walidacji tokenu (${response.statusCode}): ${response.body}');
      }
    } catch (e, stackTrace) {
      developer.log('Wyjątek podczas walidacji tokenu:', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
}); 