import 'package:flutter/material.dart';
import 'package:notes/remoteservices/note_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/loginResponse.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _password;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    //get the token
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("token");
    if (val != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/bottomNavBar', (route) => false);
    }
  }

  // void _login() async {
  //   var isValid = _form.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _form.currentState!.save();
  //   LoginResponse? loginResponse =
  //       await RemoteServices().login(_username, _password, context);

  //   if (loginResponse != null) {
  //     if (loginResponse.key != null) {
  //       print(loginResponse.key);
  //       // ScaffoldMessenger.of(context)
  //       //     .showSnackBar(SnackBar(content: Text('Successfully logged in')));

  //       // Navigator.of(context).push(MaterialPageRoute(
  //       //     builder: (context) => Home(
  //       //           token: loginResponse.key,
  //       //         )));

  //       //storage.setItem("token", loginResponse.key);

  //       Navigator.pushReplacementNamed(context, '/create');
  //     }

  //     if (loginResponse.non_field_errors != null) {
  //       loginResponse.non_field_errors!.forEach((element) {
  //         print(element);
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('Invalid login details!')));
  //       });
  //     }
  //   }
  // }

  void newLogin() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    LoginResponse? loginResponse =
        await RemoteServices().login(_username, _password, context);

    if (loginResponse != null) {
      if (loginResponse.key != null) {
        print(loginResponse.key);

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('token', loginResponse.key.toString());

        Navigator.pushReplacementNamed(context, '/bottomNavBar');
      }

      if (loginResponse.non_field_errors != null) {
        loginResponse.non_field_errors!.forEach((element) {
          print(element);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Invalid login details!')));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _form,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Login'),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email),
                        labelText: 'Username/Email',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.password),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            newLogin();
                            //_login();
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?',
                              style: TextStyle(fontSize: 17.0)),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/registration');
                      },
                      child: const Text('Click here to register',
                          style: TextStyle(fontSize: 17.0)),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
