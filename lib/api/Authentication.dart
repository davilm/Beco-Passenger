import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  Future<void> signUp(String email, String password) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(userCredential);
  }

  Future<void> signIn(String email, String password) async {
    print("----------------------------------------INICIO");
    print("email: " + email + " password: " + password);
    userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(userCredential);
  }
}
