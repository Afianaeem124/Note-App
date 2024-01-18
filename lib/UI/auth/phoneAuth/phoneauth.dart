import 'package:firebase/UI/auth/phoneAuth/verifycode.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phonecontroller = TextEditingController();

  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: phonecontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: '457 3647 384',
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.email_outlined)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter phone number';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: '+92' + phonecontroller.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        utils.flushBarErrorMessage(e.toString(), context);
                        setState(() {
                          loading = false;
                        });
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => VerifyScreen(verificationID: verificationId)));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        utils.flushBarErrorMessage(e.toString(), context);
                        setState(() {
                          loading = false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
