import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constante.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function func;

  const RoundedButton(this.text, this.func);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          minWidth: size.width * 0.8,
          color: Constante.KPrimaryColor,
          child: Text(this.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
          onPressed: this.func),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer(this.child);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Constante.KPrimaryLightColor,
          borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}

class TextFieldContainerMessage extends StatelessWidget {
  final Widget child;
  const TextFieldContainerMessage(this.child);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Constante.KPrimaryLightColor,
          borderRadius: BorderRadius.circular(18)),
      child: child,
    );
  }
}

class RoundedInput extends StatelessWidget {
  final Icon icon;
  final String hintText;

  final FormFieldValidator<String> validator;
  const RoundedInput(this.icon, this.hintText, this.validator);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFieldContainer(
      TextFormField(
          validator: validator,
          decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            border: InputBorder.none,
          )),
    ));
  }
}

class RoundedInputMessage extends StatelessWidget {
  final String hintText;
  final TextEditingController text;
  final FormFieldValidator<String> validator;
  const RoundedInputMessage(this.hintText, this.validator,this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFieldContainerMessage(
        
      TextFormField(
        controller: text,
          validator: validator,
          
          decoration: InputDecoration(
            
            hintText: hintText,
            border: InputBorder.none,
          )),
    ));
  }
}

class RoudedPasswordInput extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final String hint;
  const RoudedPasswordInput(this.hint, this.validator);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: TextFieldContainer(TextFormField(
                validator: validator,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: this.hint,
                    border: InputBorder.none,
                    icon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility))))));
  }
}
