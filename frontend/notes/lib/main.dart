import 'package:flutter/material.dart';
import 'package:notes/pages/bottomNavBar.dart';
import 'package:notes/pages/create.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/login.dart';
import 'package:notes/pages/registration/registration.dart';
import 'package:notes/pages/update.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.grey),
    initialRoute: '/login',
    routes: {
      // '/': (context) => Login(),
      '/bottomNavBar': (context) => const BottomNavBar(),
      '/home': (context) => Home(),
      '/registration':(context) => const Registration(),
      '/login': (context) => const Login(),
      '/create': (context) => const CreatePage(),
      '/update': (context) => const UpdatePage(),
      
    },
         
  ));
}
 
