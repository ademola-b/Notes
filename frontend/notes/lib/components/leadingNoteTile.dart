import 'package:flutter/material.dart';

Container LeadingNoteTile(int index) {
  index++;
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      color: Colors.grey[300],
    ),
    padding: const EdgeInsets.all(15.0),
    height: 50,
    width: 50,
    child: Center(
      child: Text(
        index.toString(),
        style: const TextStyle(fontSize: 15.0),
      ),
    ),
  );
}
