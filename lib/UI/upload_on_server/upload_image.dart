import 'dart:io';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  bool loading = false;
  final FirebaseStorage upload = FirebaseStorage.instance;

  DatabaseReference dbref = FirebaseDatabase.instance.ref('post');

  Future getimage() async {
    final pickimage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickimage != null) {
        _image = File(pickimage.path);
      } else {
        print('No Image Found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Upload Image')),
          backgroundColor: AppColors.appColor,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: InkWell(
              onTap: () {
                getimage();
              },
              child: Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 6, color: Colors.black),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!.absolute,
                          fit: BoxFit.cover,
                        )
                      : Center(child: Icon(Icons.image))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoundButton(
            title: 'Upload',
            loading: loading,
            onTap: () async {
              setState(() {
                loading = true;
              });
              Reference ref =
                  FirebaseStorage.instance.ref('/afiaNaeem/' + DateTime.now().millisecondsSinceEpoch.toString());
              UploadTask uploadimage = ref.putFile(_image!.absolute);

              Future.value(uploadimage).then((value) async {
                var newUrl = await ref.getDownloadURL();

                dbref.child('1').set({'id': '1212', 'title': newUrl.toString()}).then((value) {
                  setState(() {
                    loading = false;
                  });
                  utils.toastmessage('Image Uploaded');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  utils.flushBarErrorMessage(error.toString(), context);
                });
              }).onError((error, stackTrace) {
                utils.flushBarErrorMessage(error.toString(), context);
                setState(() {
                  loading = false;
                });
              });
            },
          )
        ]));
  }
}
