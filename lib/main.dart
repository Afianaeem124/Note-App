import 'package:firebase/UI/splash_screen.dart';
import 'package:firebase/utils/Routes/Routes.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 10, 241, 21),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Horizon'))),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
