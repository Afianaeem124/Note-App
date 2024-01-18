import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authh {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  void auth(String email, String password) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {})
        .onError((error, stackTrace) {});
  }
}
