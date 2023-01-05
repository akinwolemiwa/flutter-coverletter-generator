import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User>((ref) {
  return User(name: "Anonymous", email: "unkown@email.com", role: "unknown");
});

class User {
  User({required this.name, required this.email, this.role});
  final String name;
  final String email;
  final String? role;

  String get initials => name == "Anonymous" ? "?" : name.substring(0, 1);
}
