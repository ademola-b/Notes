import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/components/defaultTextFormField.dart';
import 'package:notes/remoteservices/note_services.dart';

import '../../models/registrationResponse.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password1;
  late String _password2;

  void _registerNow() async {
    var isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      RemoteServices remoteServices = RemoteServices();
      RegistrationResponse? registrationResponse = await remoteServices
          .registration(_username, _email, _password1, _password2, context);

      if (registrationResponse != null) {
        if (registrationResponse.email != null) {
          registrationResponse.email!.forEach((element) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(element)));
          });
        }

        if (registrationResponse.username != null) {
          registrationResponse.username!.forEach((element) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(element)));
          });
        }

        if (registrationResponse.non_field_errors != null) {
          registrationResponse.non_field_errors!.forEach((element) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(element)));
          });
        }

        if (registrationResponse.password1 != null) {
          registrationResponse.password1!.forEach((element) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(element)));
          });
        }

        if (registrationResponse.key != null) {
          print(registrationResponse.key!);
          ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Successfully Registered, Login Now')));
          Navigator.popAndPushNamed(context, '/login');
        }
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
              child: Column(children: [
                Text('REGISTER'),
                DefaultTextFormField(
                  labelText: 'Username',
                  keyboardInputType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                DefaultTextFormField(
                  labelText: 'Email',
                  keyboardInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email field is required";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                DefaultTextFormField(
                  labelText: 'Password',
                  keyboardInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password field is required";
                    }
                  },
                  onSaved: (value) {
                    _password1 = value!;
                  },
                ),
                DefaultTextFormField(
                  labelText: 'Confirm Password',
                  keyboardInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm is required";
                    }
                  },
                  onSaved: (value) {
                    _password2 = value!;
                  },
                ),
                // TextFormField(
                //   obscureText: true,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Enter your password";
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     _password = value!;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Password',
                //   ),
                // ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _registerNow();
                      },
                      child: const Text(
                        'REGISTER',
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
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: const Text('Click here to LOGIN',
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
