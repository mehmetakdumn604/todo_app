import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  static String get userId => _auth.currentUser?.uid ?? "admin";
}
