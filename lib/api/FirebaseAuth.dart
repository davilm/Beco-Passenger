import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseAuth with ChangeNotifier {
  static const _url =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBPPA7F1zvxnrYQQU9BuERbLNZ55T2OHaE";

  Future<void> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    print(json.decode(response.body));

    return Future.value();
  }
}