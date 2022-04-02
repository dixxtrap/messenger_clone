import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/NetWorking/Networking.dart';
import 'package:facebook/Providers/LoginProviders.dart';
import 'package:facebook/Screens/HomeMessage.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constante.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation button;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    button = new Tween(begin: 320.0, end: 70.0).animate(new CurvedAnimation(
        parent: animationController, curve: new Interval(0.0, 0.250)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, widget) {
        return Consumer<LoginProviders>(builder: (_, model, __) {
          return GestureDetector(
            onTap: () async {
              print("fonction");
              print(model.email);
              //animationController.forward();
              if (model.keyForm.currentState.validate()) {
                print("eci nga");
                print("model:");
                print(model.email);
                var bl = await Constante.getAlert(
                    context, CircularProgressIndicator.adaptive());
                bl.style(
                    message: 'Inscription en cours',
                    backgroundColor: Colors.blue,
                    messageTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.w600));
                await bl.display();
                try {
                  int result = await Networking.inscription(
                      model.email,
                      model.password,
                      model.username,
                      model.name,
                      model.file.path);
                  print("=============================test==========" +
                      result.toString());
                  if (result == 1) {
                    print("Connexion Etablie");
                    bl.close();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeMessage()));
                  } else {
                    var wrong = await Constante.getAlert(
                        context, Icon(Icons.warning_rounded));
                    wrong.style(
                        message: "Something is wrong do it again",
                        backgroundColor: Colors.blue,
                        messageTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600));

                    wrong.display();
                    Future.delayed(Duration(seconds: 2)).whenComplete(() {
                      wrong.close();
                    });
                  }
                } catch (e) {
                  var wrongg = await Constante.getAlert(
                      context, Icon(Icons.warning_rounded));
                  wrongg.style(
                      message: "Something is wrong do it again",
                      backgroundColor: Colors.blue,
                      messageTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w600));

                  wrongg.display();
                  Future.delayed(Duration(seconds: 4)).whenComplete(() {
                    wrongg.close();
                  });
                }
              }
              ;
            },
            child: Container(
              width: button.value,
              height: 40,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.blue),
              child: button.value > 70
                  ? Text(
                      "S'inscrire",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )),
            ),
          );
        });
      },
    );
  }
}
