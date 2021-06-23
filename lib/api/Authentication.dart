import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  Future<void> signUp(
    String email,
    String name,
    String cpf,
    String password,
  ) async {
    userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final userData = {
      'name': name,
      'cpf': cpf,
      'email': email,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userData);
  }

  Future<void> signIn(String email, String password) async {
    userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
