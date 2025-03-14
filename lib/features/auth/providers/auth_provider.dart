import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../models/user.dart';
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
      final response = await _authService.getUserFromToken(token);
      
      if (response != null && response['valid']) {
        final userData = response['user'];
        final user = User(
          id: userData['id'],
          name: userData['name'],
          email: userData['email'],
          role: userData['role'],
          token: token,
        );
        
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
      
      final response = await _authService.login(email, password);
      
      if (response['token'] != null) {
        await _secureStorage.saveToken(response['token']);
        
        final user = User(
          id: response['user']['id'],
          name: response['user']['name'],
          email: response['user']['email'],
          role: response['user']['role'],
          token: response['token'],
        );
        
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
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