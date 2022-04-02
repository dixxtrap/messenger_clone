
import 'package:facebook/GeneratedRoutes.dart';
import 'package:facebook/constante.dart';
import 'package:facebook/service/auth.dart';
import 'package:facebook/widgets/roundedButton.dart';
import 'package:flutter/material.dart';



class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              child: Image.asset(
                  "female-freelancer-working-on-project-3839583-3202977.png"),
            )),
            RoundedInput(Icon(Icons.person), "Enter votre Email", 
              (value) {
                  if (value.contains("@")) {
                   
                    return null;
                  } else
                    return "password not good";
                }
            ),
            // ignore: missing_return
            RoudedPasswordInput("password",(value) {}),
            RoundedButton("Se connecter", () {}),
            Container(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  AuthMethods().signInWithGoogle(context);
                },
                child: Text(
                  "se connecter avec google",
                  style:
                      TextStyle(fontSize: 20, color: Constante.KPrimaryColor),
                )),
            Container(
              height: 2,
            ),
            TextButton(
                onPressed: () {
                  GeneratedRoutes.loginScreen;
                },
                child: Text(
                  "S'inscrire",
                  style:
                      TextStyle(fontSize: 20, color: Constante.KPrimaryColor),
                )),
            Container(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
