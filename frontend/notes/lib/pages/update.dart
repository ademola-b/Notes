import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes/components/defaultTextField.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/remoteservices/note_services.dart';

class UpdatePage extends StatefulWidget {
  // final NoteArgs? noteArgs;

  // final int id;
  // final String body;

  const UpdatePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Map note_data = {};

  Client client = http.Client();
  late final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    //_bodyController.text = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    note_data = ModalRoute.of(context)?.settings.arguments as Map;
    _bodyController.text = note_data['note'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
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
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    //updateNote(_bodyController.text, widget.id);
                    if (_bodyController.text.isNotEmpty) {
                      updateNote(_bodyController.text, note_data['id']);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Note Successfully Updated!')));
                      Navigator.of(context).pop(true);
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Note can't be empty")));
                    }
                  },
                  child: const Text(
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
