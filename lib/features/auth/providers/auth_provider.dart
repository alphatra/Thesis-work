import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';
import '../../../shared/services/secure_storage_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final SecureStorageService _secureStorage;

  AuthNotifier(this._authService, this._secureStorage) 
      : super(const AuthState());

  Future<void> checkAuthStatus() async {
    try {
      final token = await _secureStorage.getToken();
      
      if (token == null) {
        state = state.copyWith(status: AuthStatus.unauthenticated);
        return;
      }
      
      state = state.copyWith(status: AuthStatus.authenticating);
      final user = await _authService.getUserFromToken(token);
      
      if (user != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        await _secureStorage.deleteToken();
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(status: AuthStatus.authenticating);
      
      final result = await _authService.login(email, password);
      
      if (result.token.isNotEmpty) {
        await _secureStorage.saveToken(result.token);
        
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: result.user,
        );
      } else {
        throw Exception('Invalid token received');
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthNotifier(authService, secureStorage);
});