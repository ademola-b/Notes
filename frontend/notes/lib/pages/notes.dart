import 'package:flutter/material.dart';
import 'package:notes/components/leadingNoteTile.dart';
import 'package:notes/components/noNote.dart';
import 'package:notes/models/note.dart';
import 'package:notes/remoteservices/note_services.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final TextEditingController _searchController = TextEditingController();

  List<Note>? notes, futureNotes = [];

  late Future<List<Note>?> futureN;

  @override
  void initState() {
    super.initState();
    futureN = RemoteServices().getNotes(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Note>?>(
                future: futureN,
                builder: (context, snapshot) {
                  var _notes = snapshot.data;
                  if (snapshot.hasData) {
                    return _notes!.isEmpty
                        ? NoNote()
                        : Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _notes == null ? 0 : _notes.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Colors.grey[200],
                                      ),
                                      child: ListTile(
                                        leading: LeadingNoteTile(index),
                                        title: Text(_notes[index].body),
                                        trailing: Column(children: [
                                          Text('Date '),
                                          SizedBox(height: 5.0),
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      print(
                                                          'Edit Button clicked');
                                                    },
                                                    icon: Icon(Icons.edit)),
                                                SizedBox(width: 20.0),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  );
                                }),
                          );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return CircularProgressIndicator();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool refresh =
                await Navigator.pushNamed(context, '/create') as bool;

            // if (refresh != null) {
            //   RemoteServices().getNotes(context);
            // } else {}
          },
          child: const Text(
            '+',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
