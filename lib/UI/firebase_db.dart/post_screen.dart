import 'package:firebase/utils/Routes/routes_name.dart';
import 'package:firebase/utils/colors.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final databaseref = FirebaseDatabase.instance.ref('post');
  final searchcontroller = TextEditingController();
  final updatecontroller = TextEditingController();

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
        title: Center(child: Text('Note')),
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
          Navigator.pushNamed(context, RoutesName.addpost);
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
              child: FirebaseAnimatedList(
                  defaultChild: Text('Loading'),
                  query: databaseref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();

                    if (searchcontroller.text.isEmpty) {
                      return Card(
                        color: Color.fromARGB(255, 160, 108, 153),
                        child: ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                          subtitle: Text(snapshot.child('id').value.toString()),
                          trailing: PopupMenuButton(
                              elevation: 3,
                              iconColor: Colors.black,
                              color: AppColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.black)),
                              itemBuilder: (context) => [
                                    ////////////EDIT
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            ShowdialogBox(
                                                title,
                                                snapshot
                                                    .child('id')
                                                    .value
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
                                            databaseref
                                                .child(snapshot
                                                    .child('id')
                                                    .value
                                                    .toString())
                                                .remove()
                                                .then((value) {
                                              utils.toastmessage(
                                                  ' Post deleted');
                                            }).onError((error, stackTrace) {
                                              utils.flushBarErrorMessage(
                                                  error.toString(), context);
                                            });
                                          },
                                          title: Text('Delete'),
                                          trailing: Icon(
                                              Icons.delete_forever_outlined),
                                        )),
                                  ]),
                        ),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(searchcontroller.text.toLowerCase())) {
                      return Card(
                        color: Color.fromARGB(255, 160, 108, 153),
                        child: ListTile(
                          title: Text(snapshot.child('title').value.toString()),
                          subtitle: Text(snapshot.child('id').value.toString()),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
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
                  },
                  child: Text('Cancle')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    databaseref.child(id).update({
                      'title': updatecontroller.text.toLowerCase()
                    }).then((value) {
                      utils.toastmessage('Post Updated');
                    }).onError((error, stackTrace) {
                      utils.flushBarErrorMessage(error.toString(), context);
                    });
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
////USING STREAM BUILDER(CAN BE USED ANYWHERE)
          // Expanded(
          //     child: StreamBuilder(
          //         stream: databaseref.onValue,
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             Map<dynamic, dynamic> map =
          //                 snapshot.data!.snapshot.value as dynamic;

          //             List<dynamic> list = [];
          //             list = map.values.toList();

          //             return ListView.builder(
          //                 itemCount: snapshot.data!.snapshot.children.length,
          //                 itemBuilder: (context, index) {
          //                   return ListTile(
          //                     title: Text(list[index]['title']),
          //                     subtitle: Text(list[index]['id']),
          //                   );
          //                 });
          //           } else {
          //             return Text('loading');
          //           }
          //         })),
          
