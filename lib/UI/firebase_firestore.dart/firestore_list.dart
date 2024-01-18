import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final searchcontroller = TextEditingController();
  final updatecontroller = TextEditingController();

  final firestore =
      FirebaseFirestore.instance.collection(' Syeda Afia Naeem').snapshots();

///////BOTH SAME(COLLECTIONREFERENCE IS PREFERRED METHOD)
  //final ref = FirebaseFirestore.instance.collection(' Syeda Afia Naeem');
  CollectionReference ref =
      FirebaseFirestore.instance.collection(' Syeda Afia Naeem');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //databaseref.onValue.listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('FireStore Post')),
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.insertfirestore);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: firestore,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final title = snapshot.data!.docs[index]['title']
                                  .toString();
                              if (searchcontroller.text.isEmpty) {
                                return Card(
                                  color: Color.fromARGB(255, 160, 108, 153),
                                  child: ListTile(
                                    title: Text(snapshot
                                        .data!.docs[index]['title']
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.docs[index]['id']
                                        .toString()),
                                    trailing: PopupMenuButton(
                                        elevation: 3,
                                        iconColor: Colors.black,
                                        color: AppColors.buttonColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: Colors.black)),
                                        itemBuilder: (context) => [
                                              ////////////EDIT
                                              PopupMenuItem(
                                                  value: 1,
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      ShowdialogBox(
                                                          title,
                                                          snapshot.data!
                                                              .docs[index]['id']
                                                              .toString());
                                                    },
                                                    title: Text('Edit'),
                                                    trailing: Icon(Icons.edit),
                                                  )),
                                              ////////////DELETE
                                              PopupMenuItem(
                                                  value: 2,
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      ref
                                                          .doc(snapshot.data!
                                                              .docs[index]['id']
                                                              .toString())
                                                          .delete()
                                                          .then((value) {
                                                        utils.toastmessage(
                                                            'Post Deleted');
                                                      }).onError((error,
                                                              stackTrace) {
                                                        utils
                                                            .flushBarErrorMessage(
                                                                error
                                                                    .toString(),
                                                                context);
                                                      });
                                                    },
                                                    title: Text('Delete'),
                                                    trailing: Icon(Icons
                                                        .delete_forever_outlined),
                                                  )),
                                            ]),
                                  ),
                                );
                              } else if (title.toLowerCase().contains(
                                  searchcontroller.text.toLowerCase())) {
                                return Card(
                                  color: Color.fromARGB(255, 160, 108, 153),
                                  child: ListTile(
                                    title: Text(snapshot
                                        .data!.docs[index]['title']
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.docs[index]['id']
                                        .toString()),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Text('loading');
                      }
                    })),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowdialogBox(String title, String id) async {
    updatecontroller.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: updatecontroller,
                decoration: InputDecoration(
                    hintText: 'Edit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    )),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .doc(id)
                        .update({'title': updatecontroller.text}).then((value) {
                      utils.toastmessage('Post Updated');
                    }).onError((error, stackTrace) {
                      utils.flushBarErrorMessage(error.toString(), context);
                    });
                  },
                  child: Text('Update')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancle')),
            ],
          );
        });
  }
}
