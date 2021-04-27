import 'package:flutter/material.dart';
import 'TelaLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main(){

  runApp(MaterialApp(
    home: TelaLogin(),
    debugShowCheckedModeBanner: false,
  ));

}