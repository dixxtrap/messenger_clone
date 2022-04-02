import 'package:facebook/Screens/HomeMessage.dart';
import 'package:facebook/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class GeneratedRoutes {
  static const String home = "/home";
  static const String loginScreen = "/";

  static const String detailScreen = "/detailScreen";

  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (context) => HomeMessage());
      // case detailScreen:
      //   if (args is List<Personne>)
      //     return MaterialPageRoute(builder: (context) => DetailScreen(args,args));
        break;
      default:
        return MaterialPageRoute(builder: (context) => null);
    }
  }
}
