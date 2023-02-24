// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes/models/note.dart';
import 'package:notes/remoteservices/note_services.dart';

import '../components/defaultTextField.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  Client client = http.Client();
  final TextEditingController _bodyController = TextEditingController();

  User? sid;
  List<User> users = [];

  //fetch users
  // Future<List<User>>? getUsers() async {
  //   var response = await client.get(usersUrl); //get list of users from api
  //   var jsonData = response.body; //list of users stored in the body section of the returned data
  //   return userFromJson(jsonData);
  // }

  // Future<void> fetchandShow() async {
  //   final users = await getUsers();
  //   setState(() {
  //     this.users = users ?? [];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //fetchandShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DefaultTextField(
                controller: _bodyController,
                maxLines: 10,
                hintText: 'Type note here',
              ),
              const SizedBox(height: 15.0),
              // Container(
              //   width: MediaQuery.of(context).size.height,
              //   padding: EdgeInsets.symmetric(horizontal: 20.0),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     color: Colors.grey[100],
              //   ),
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     child: DropdownButtonFormField<User>(
              //       hint: Text('Select user'),
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //       ),
              //       value: sid,
              //       items: users
              //           .map((item) => DropdownMenuItem(
              //                 value: item,
              //                 child: Text(
              //                   item.username,
              //                   style: TextStyle(fontSize: 20.0),
              //                 ),
              //               ))
              //           .toList(),
              //       onChanged: (item) => setState(() {
              //         sid = item;
              //         print('email - ${sid?.email}');
              //         print('id - ${sid?.id}');
              //         print('username - ${sid?.username}');
              //       }),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () async {
                    await createNote(
                        _bodyController.text); //, int.parse(sid!.id.toString())
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Note Successfully Added!')));
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
