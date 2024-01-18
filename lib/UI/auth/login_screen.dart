import 'package:firebase/utils/colors.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:flutter/services.dart';
import 'package:firebase/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  ValueNotifier<bool> _obscurepass = ValueNotifier<bool>(true);

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, RoutesName.postscreen);
      utils.toastmessage('Login Successfully');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('Login', style: TextStyle(color: AppColors.whiteColor))),
          backgroundColor: AppColors.appColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      focusNode: emailfocus,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.email_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email ';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) {
                        emailfocus.unfocus();
                        FocusScope.of(context).requestFocus(passwordfocus);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _obscurepass,
                        builder: (context, value, child) {
                          return TextFormField(
                            controller: passwordcontroller,
                            obscureText: _obscurepass.value,
                            focusNode: passwordfocus,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _obscurepass.value = !_obscurepass.value;
                                    },
                                    child: _obscurepass.value
                                        ? Icon(Icons.visibility_off_outlined)
                                        : Icon(Icons.visibility))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter password ';
                              } else {
                                return null;
                              }
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: RoundButton(
                      title: 'Login',
                      loading: loading,
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          login();
                        }
                      })),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.forgetpassword);
                    },
                    child: Text('Forgot Password',
                        style: TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.bold))),
              ),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Dont have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.signup);
                    },
                    child: Text('Sign Up'))
              ]),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.phone);
                  },
                  child: Text(
                    'Login with phone',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  style: TextButton.styleFrom(
                      side: BorderSide(style: BorderStyle.solid, color: Colors.black),
                      backgroundColor: AppColors.buttonColor))
            ],
          ),
        ),
      ),
    );
  }
}
