import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/userResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/loginResponse.dart';
import '../models/registrationResponse.dart';
import 'urls.dart';

Client client = http.Client();

class RemoteServices {
  //get notes
  Future<List<Note>> getNotes(context) async {
    try {
      var client = http.Client();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response =
          await client.get(noteUrl, headers: {"Authorization": "Token $token"});

      //if data is retrieved
      if (response.statusCode == 200) {
        var json = response.body; //string format
        final note =
            noteFromJson(json); //convert returned data to list of notes
        return note;
      }
      return <Note>[];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There's a problem with your connection")));
      return <Note>[];
    }
  }

  //registration
  Future<RegistrationResponse?> registration(String username, String email,
      String password, String password2, context) async {
    try {
      var response = await http.post(registrationUrl, body: {
        'username': username,
        'email': email,
        'password1': password,
        'password2': password2
      });
      var data = response.body;
      return RegistrationResponse.fromJson(jsonDecode(data));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There's a problem with your connection")));
    }
  }

  //login with email/password
  Future<LoginResponse?> login(
      String username, String password, context) async {
    try {
      var response = await http.post(loginUrl, body: {
        'username': username,
        'password': password,
      });

      var data = response.body;
      //print(response.body); string value of response
      return LoginResponse.fromJson(jsonDecode(data));
    } catch (e) {
      // print("There's a problem with your connection");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There's a problem with your connection.")));
    }
    
  }

  //get user detail
  Future<UserResponse?> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var response =
          await http.get(userUrl, headers: {"Authorization": "Token $token"});
      return UserResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
  }

  //login
  Future<bool> loginNow(String username, String password) async {
    try {
      http.Response response = await http.post(loginUrl,
          headers: {'content-type': 'application/json; charset=UTF-8'},
          body: json.encode({'username': username, 'password': password}));
      var data = json.decode(response.body);
      print(data);
      if (data.containsKey('key')) {
        print(data['key']);
        return false;
      }

      return true;
    } catch (e) {
      print('error loginNow');
      print(e);

      return false;
    }
  }
}

//create note
Future<Note?> createNote(String body) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var token = pref.getString('token');

  var data = jsonEncode({"body": body}); //, "user": uid
  var response = await http.post(noteUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token'
      },
      body: data);
  print(data);
  try {
    if (response.statusCode == 201) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create note');
    }
  } catch (e) {
    print(e);
  }
}

//delete note
Future<void> deleteNote(int id) async {
  var response = await http.delete(Uri.parse('$base_url/notes/$id/delete/'),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8'
      });
}

//update
Future<Note> updateNote(String body, int id) async {
  var response = await http.put(Uri.parse("$base_url/notes/$id/update/"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'body': body}));

  if (response.statusCode == 200) {
    return Note.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update note');
  }
}
