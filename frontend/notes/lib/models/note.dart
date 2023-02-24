import 'dart:convert';

// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    this.id,
    required this.body,
    this.updated,
    this.created,
    this.user,
  });

  int? id;
  String body;
  DateTime? updated;
  DateTime? created;
  User? user;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        body: json["body"] as String,
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
        user: User.fromJson(json["user"]),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "updated": updated?.toIso8601String(),
        "created": created?.toIso8601String(),
        "user": user?.toJson()
      };
}

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class User {
  User({
    this.id,
    required this.username,
    this.password,
    this.email,
  });

  int? id;
  String username;
  String? password;
  String? email;


  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "email": email,
      };
}