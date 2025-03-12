import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/auth_result.dart';
import '../../../shared/services/grpc_service.dart';

class AuthService {
  final GrpcService _grpcService;

  AuthService(this._grpcService);

  Future<AuthResult> login(String email, String password) async {
    try {
      // TODO: Implement actual gRPC call when proto files are generated
      // Temporary mock implementation
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.trim().toLowerCase() == "test@test.com" && password == "password") {
        return AuthResult(
          token: "mock_token",
          user: User(
            id: "1",
            name: "Test User",
            email: email,
            role: "user",
          ),
        );
      }
      
      throw Exception('Nieprawidłowy email lub hasło');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<User?> getUserFromToken(String token) async {
    try {
      // TODO: Implement actual gRPC call when proto files are generated
      // Temporary mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (token == "mock_token") {
        return User(
          id: "1",
          name: "Test User",
          email: "test@test.com",
          role: "user",
        );
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final grpcService = ref.watch(grpcServiceProvider);
  return AuthService(grpcService);
});