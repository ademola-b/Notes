import 'package:flutter/material.dart';

class NoNote extends StatelessWidget {
  const NoNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Icon(
          Icons.sticky_note_2,
          size: 150.0,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
