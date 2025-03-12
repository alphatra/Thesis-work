import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class UserService {
  final Ref ref;

  UserService(this.ref);

  Future<void> logout() async {
    // Implement your logout logic here
    // For example:
    // await authService.signOut();
    ref.read(userProvider.notifier).clearUser();
  }

  Future<void> switchAccount() async {
    // Implement your account switching logic here
  }

  Future<void> updateProfile() async {
    // Implement your profile update logic here
  }

  Future<void> updatePreferences() async {
    // Implement your preferences update logic here
  }
}

final userServiceProvider = Provider((ref) => UserService(ref));