import 'dart:async';

import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 35), () => Navigator.pushNamed(context, RoutesName.postscreen));
    } else {
      Timer(Duration(seconds: 35), () => Navigator.pushNamed(context, RoutesName.login));
    }
  }
}
