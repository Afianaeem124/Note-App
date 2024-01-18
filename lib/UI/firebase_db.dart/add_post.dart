import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController postcontroller = TextEditingController();
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add Note')),
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
                    hintText: 'Create a mind map',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                  title: 'Add',
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    String id = DateTime.now().millisecondsSinceEpoch.toString();
                    databaseref.child(id).set({'title': postcontroller.text.toString(), 'id': id}).then((value) {
                      utils.toastmessage('Post Added');
                      Navigator.pushNamed(context, RoutesName.postscreen);
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
