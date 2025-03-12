class User {
  final String name;
  final String email;
  final String? avatarUrl;
  final String role;

  const User({
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.role,
  });
}
