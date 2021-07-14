import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  late UserCredential userCredential;

  Future<String> signOut() async {
    await _auth.signOut();
    return "Sign Out";
  }

  Future<void> signUp(
    String email,
    String name,
    String cpf,
    String password,
  ) async {
    String photoURL =
        "https://firebasestorage.googleapis.com/v0/b/beco-9fab4.appspot.com/o/face-light.png?alt=media&token=ceaba8cb-80ec-4f20-a56f-976f16d22216";

    userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    UpdateCurrentUser(
      displayName: name,
      newEmail: email,
      photoURL: photoURL,
      newPassword: password,
    );

    final userData = {
      'name': name,
      'cpf': cpf,
      'email': email,
      'imageUrl': photoURL,
    };

    await FirebaseFirestore.instance
        .collection('passengers')
        .doc(userCredential.user!.uid)
        .set(userData);
  }

  Future<String> signIn(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<void> UpdateCurrentUser({
    required displayName,
    required newEmail,
    required photoURL,
    required newPassword,
  }) async {
    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    user!.updateDisplayName(displayName);
    user.updateEmail(newEmail);
    user.updatePhotoURL(photoURL);
    user.updatePassword(newPassword);
  }
}
