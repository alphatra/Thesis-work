import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class UserState {
  final User? user;
  final bool isLoading;
  final String? error;

  const UserState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  void setUser(User user) {
    state = UserState(user: user);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  void clearUser() {
    state = const UserState();
  }

  void updateUserData({
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    if (state.user == null) return;

    final updatedUser = state.user!.copyWith(
      name: name,
      email: email,
      avatarUrl: avatarUrl,
    );

    state = state.copyWith(user: updatedUser);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});