import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  final String labelText;
  final Function onSaved;
  final Function validator;
  final bool? obscureText;
  final keyboardInputType;

  const DefaultTextFormField({
    Key? key,
    required this.labelText,
    required this.onSaved,
    required this.validator,
    required this.keyboardInputType,
    this.obscureText,
  }) : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardInputType,
      validator: (value) => widget.validator(value),
      onSaved: (value) => widget.onSaved(value),
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
    );
  }
}
