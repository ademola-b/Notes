import 'package:flutter/material.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/more.dart';
import 'package:notes/pages/notes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [Home(), Notes(), More()];

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More')
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 25,
        selectedItemColor: Colors.grey[900],
        onTap: _onTappedItem,
        
      ),
    );
  }
}
