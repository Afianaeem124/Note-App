import 'package:firebase/utils/colors.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  ValueNotifier<bool> _obscurepass = ValueNotifier<bool>(true);

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) {
      setState(() {
        loading = false;
      });
      utils.toastmessage('Sign Up Successfully');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });

      utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
            child:
                Text('Sign Up', style: TextStyle(color: AppColors.whiteColor))),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email_outlined)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email ';
                      } else if (!value.contains('@')) {
                        return 'Invalid Email ';
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                    title: 'Sign Up',
                    loading: loading,
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        signup();
                      }
                    })),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Alreay have an account?'),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: Text('Login'))
            ])
          ],
        ),
      ),
    );
  }
}
