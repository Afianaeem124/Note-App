import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/utils.dart';

class InsertFirestore extends StatefulWidget {
  const InsertFirestore({super.key});

  @override
  State<InsertFirestore> createState() => _InsertFirestoreState();
}

class _InsertFirestoreState extends State<InsertFirestore> {
  TextEditingController postcontroller = TextEditingController();
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection(' Syeda Afia Naeem');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add Post')),
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
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: 'What is in your mind?',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.post_add_rounded)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter post';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Post',
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    firestore.doc(id).set({
                      'title': postcontroller.text.toString(),
                      'id': id
                    }).then((value) {
                      utils.toastmessage('Post Added');
                      Navigator.pushNamed(context, RoutesName.firestorelist);
                    }).onError((error, stackTrace) {
                      utils.flushBarErrorMessage(error.toString(), context);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
