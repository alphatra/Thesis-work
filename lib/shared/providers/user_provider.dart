import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

// Przykładowy aktualny użytkownik
const currentUser = User(
  name: 'Jan Kowalski',
  email: 'jan.kowalski@example.com',
  role: 'Administrator',
);

final userProvider = Provider<User>((ref) => currentUser);
