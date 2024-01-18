import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController postcontroller = TextEditingController();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Forgot Password')),
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: postcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Send',
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });

                    auth.sendPasswordResetEmail(email: postcontroller.text.toString()).then((value) {
                      utils.toastmessage('A link is send to your email please check');
                      Navigator.pushNamed(context, RoutesName.postscreen);
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      utils.flushBarErrorMessage(error.toString(), context);
                      setState(() {
                        loading = false;
                      });
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
