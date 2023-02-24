import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/components/leadingNoteTile.dart';
import 'package:notes/components/noNote.dart';
import 'package:notes/models/userResponse.dart';
import 'package:notes/remoteservices/note_services.dart';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client client = http.Client();
  List<Note> notes = [];
  String? _username = 'Loading...';
  UserResponse? user;
  bool isLoaded = false;

  late Future<List<Note>?> futureN;

  @override
  void initState() {
    futureN = RemoteServices().getNotes(context);
    _getUser();
    getData();
    super.initState();

    RemoteServices().getNotes(context).then((value) {
      setState(() {
        notes = [...notes, ...value];
      });
    });
  }

  Future _getUser() async {
    user = await RemoteServices().getUser();
    if (user != null) {
      setState(() {
        _username = user!.username;
      });
    }
  }

  Future getData() async {
    notes = await RemoteServices().getNotes(context);
    if (notes != null) {
      setState(() {
        isLoaded = true;
      });
    }
    return notes;
  }

  //delete note
  void _deleteNote(int? id) {
    (deleteNote(id!));
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note Successfully Deleted!')));
    getData();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      //body: _widgetOptions.elementAt(_selectedIndex),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, \n\t\t\t $_username',
                style: const TextStyle(fontSize: 20.0),
              ),

              const SizedBox(
                height: 50.0,
              ),
              const Text(
                'Latest Notes',
                style: TextStyle(fontSize: 20.0),
              ),

              Visibility(
                visible: isLoaded,
                replacement: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )),
                child: Expanded(
                  child: notes.isEmpty? const NoNote(): ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            //border: Border.all(width: 1.0),
                            color: Colors.grey[200],
                          ),
                          child: ListTile(
                            onTap: () async {
                              final bool refresh = await Navigator.pushNamed(
                                  context, '/update',
                                  arguments: {
                                    'id': notes[index].id,
                                    'note': notes[index].body,
                                  }) as bool;

                              if (refresh != null) {
                                getData();
                              } else {}
                            },
                            leading: LeadingNoteTile(index),
                            title: Text(notes[index].body),
                            trailing: Column(
                              children: [
                                Expanded(
                                    child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          _deleteNote(notes[index].id);
                                          setState(() {
                                            isLoaded = true;
                                          });
                                        })),
                                // Text(
                                //     "posted by - ${notes![index].user?.username}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),


              // FutureBuilder<List<Note>?>(
              //     future: futureN,
              //     builder: (context, snapshot) {
              //       var _notes = snapshot.data;
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //             scrollDirection: Axis.vertical,
              //             shrinkWrap: true,
              //             itemCount: _notes == null ? 0 : _notes.length,
              //             itemBuilder: (context, index) {
              //               return Padding(
              //                 padding:
              //                     const EdgeInsets.symmetric(vertical: 8.0),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: const BorderRadius.all(
              //                         Radius.circular(10.0)),
              //                     color: Colors.grey[200],
              //                   ),
              //                   child: ListTile(
              //                     leading: LeadingNoteTile(index),
              //                     title: Text(_notes![index].body),
              //                   ),
              //                 ),
              //               );
              //             });
              //       } else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       } else if (snapshot.hasData && snapshot.data == null) {
              //         return const Text('No note');
              //       }

              //       return const CircularProgressIndicator();
              //     })
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       final bool refresh =
              //           await Navigator.pushNamed(context, '/create') as bool;

              //       if (refresh != null) {
              //         getData();
              //       } else {}
              //     },
              //     child: Text('Add Note'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool refresh =
              await Navigator.pushNamed(context, '/create') as bool;

          if (refresh != null) {
            getData();
          } else {}
        },
        child: const Text(
          '+',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
