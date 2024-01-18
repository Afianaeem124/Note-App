import 'package:firebase/UI/auth/login_screen.dart';
import 'package:firebase/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Center(
        //   child: Expanded(
        //     child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
        //       TyperAnimatedText('Whats on your mind?',
        //           textStyle: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontStyle: FontStyle.italic,
        //               color: AppColors.purpleColor,
        //               fontSize: 50)),
        //     ]),
        //   ),
        //),
        Expanded(
          child: AnimatedSplashScreen(
            splash: Image.network(
              'https://cdn-icons-gif.flaticon.com/12743/12743767.gif',
            ),
            nextScreen: LoginScreen(),
            splashIconSize: 130,

            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Color.fromARGB(255, 161, 129, 33),
            //pageTransitionType: PageTransitionType.scale,
          ),
        ),
      ],
    ));
  }
}
