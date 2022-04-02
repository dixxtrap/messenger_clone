import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(25)),
        child:TextField(
          cursorColor: Colors.black.withOpacity(0.2),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Search", 
            border: InputBorder.none
          ),
          ),
      );
    
  }
}