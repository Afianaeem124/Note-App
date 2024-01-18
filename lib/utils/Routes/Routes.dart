import 'package:firebase/UI/auth/forgotpass.dart';
import 'package:firebase/UI/auth/login_screen.dart';
import 'package:firebase/UI/auth/phoneAuth/phoneauth.dart';
import 'package:firebase/UI/auth/phoneAuth/verifycode.dart';
import 'package:firebase/UI/auth/signup_screen.dart';
import 'package:firebase/UI/firebase_db.dart/add_post.dart';
import 'package:firebase/UI/firebase_db.dart/post_screen.dart';
import 'package:firebase/UI/firebase_firestore.dart/firestore_list.dart';
import 'package:firebase/UI/firebase_firestore.dart/insert_firestore.dart';
import 'package:firebase/UI/splash_screen.dart';
import 'package:firebase/UI/upload_on_server/upload_image.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.postscreen:
        return MaterialPageRoute(builder: (context) => PostScreen());
      case RoutesName.phone:
        return MaterialPageRoute(builder: (context) => PhoneAuth());
      case RoutesName.addpost:
        return MaterialPageRoute(builder: (context) => AddPostScreen());
      case RoutesName.firestorelist:
        return MaterialPageRoute(builder: (context) => FirestoreListScreen());
      case RoutesName.insertfirestore:
        return MaterialPageRoute(builder: (context) => InsertFirestore());
      case RoutesName.uploadImage:
        return MaterialPageRoute(builder: (context) => UploadImageScreen());
         case RoutesName.forgetpassword:
        return MaterialPageRoute(builder: (context) =>ForgotPasswordScreen());
      // case RoutesName.verify:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           VerifyScreen(verificationID: settings.arguments as String));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(body: Center(child: Text('No Route Defined')));
        });
    }
  }
}
