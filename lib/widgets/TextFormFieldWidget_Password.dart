import 'package:flutter/material.dart';

class TextFormFieldWidget_Password extends StatelessWidget {
  String label;
  Icon icon;
  FormFieldValidator<String> onChanger;

  TextFormFieldWidget_Password(this.label, this.icon, this.onChanger);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        obscureText: true,
        validator: onChanger,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.black),
            hintText: label,
            prefixIcon: icon,
            fillColor: Colors.white70),
      ),
    );
  }
}
