import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularImageUser extends StatelessWidget {
  
  String urlImage;
  double radius;
  CircularImageUser({@required this.urlImage, @required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(urlImage),
        fit: BoxFit.fill
        )
      ),

    );
  }
}
