import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  final List<String> _labels = [
    'Account Settings',
    'Help Center',
    'Contact Us',
    'About Application'
  ];

  List<dynamic> _labelIcons = [
    Icons.settings,
    Icons.help,
    Icons.email,
    Icons.info
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  height: 250.0,
                  child: Image(
                    image: AssetImage('assets/cool_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -70,
                  child: Container(
                    height: 170.0,
                    width: 170.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.white, width: 4.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -100,
                  child: Text(
                    'Username',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 110.0),
                  itemCount: _labels.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: ListTile(
                        leading: Icon(_labelIcons[index]),
                        title: Text(_labels[index]),
                        trailing: const Icon(Icons.arrow_forward_outlined),
                        onTap: () {},
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  //delete token from store
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
