import 'package:firebase/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:another_flushbar/flushbar.dart';

class utils {
  static void toastmessage(String msg) {
    Fluttertoast.showToast(
        timeInSecForIosWeb: 3,
        msg: msg,
        backgroundColor: AppColors.successColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        fontSize: 16);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.easeInToLinear,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        duration: Duration(seconds: 9),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        message: message,
        backgroundColor: AppColors.errorColor,
        reverseAnimationCurve: Curves.easeInExpo,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }
}
