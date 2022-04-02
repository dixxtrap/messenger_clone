import 'package:facebook/GeneratedRoutes.dart';
import 'package:flutter/material.dart';
class APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: GeneratedRoutes.loginScreen,
      onGenerateRoute: GeneratedRoutes.onGeneratedRoute,
      
    );
  }
}