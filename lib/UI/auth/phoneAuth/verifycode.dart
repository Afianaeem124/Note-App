import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationID;
  const VerifyScreen({super.key, required this.verificationID});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController verifycontroller = TextEditingController();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Verify')),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: verifycontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter 6 digit code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.email_outlined)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter 6 didgit code';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credentiaal = PhoneAuthProvider.credential(
                      verificationId: widget.verificationID,
                      smsCode: verifycontroller.text.toString());
                  try {
                    await auth.signInWithCredential(credentiaal);
                    Navigator.pushNamed(context, RoutesName.postscreen);
                  } catch (e) {
                    utils.flushBarErrorMessage(e.toString(), context);
                    setState(() {
                      loading = false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
