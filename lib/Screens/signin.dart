import 'package:animatedloginbutton/animatedloginbutton.dart';
import 'package:facebook/Networking/Networking.dart';
import 'package:facebook/Providers/SignInProvider.dart';
import 'package:facebook/Screens/LoginScreen.dart';
import 'package:facebook/constante.dart';
import 'package:facebook/service/auth.dart';
import 'package:facebook/widgets/roundedButton.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeMessage.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        child: Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Consumer<SignInProvider>(builder: (_, model, __) {
                  final FormFieldValidator<String> emailValidator = (value) {
                    if (value.contains("@")) {
                      model.email = value;
                      return null;
                    } else
                      return "password not good";
                  };
                  final FormFieldValidator<String> passwordValidator = (value) {
                    if (value.length >= 6) {
                      model.password = value;
                      return null;
                    } else
                      return "password not good";
                  };
                  return Form(
                    key: model.keyForm,
                    child: ListView(
                      children: [
                        homeImg(),
                        RoundedInput(Icon(Icons.person), "Enter votre Email",
                            emailValidator),
                        RoudedPasswordInput("password", passwordValidator),
                       
                        RoundedButton("Se connecter", () async {
                          if (model.keyForm.currentState.validate()) {
                            var bl = await Constante.getAlert(context,CircularProgressIndicator.adaptive());
                            bl.style(
                                message: 'Loading File...',
                                backgroundColor: Colors.blue,
                                messageTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w600));
                            await bl.display();
                            try {
                              int result = await Networking.connexion(
                                  model.email, model.password);
                              if (result == 1) {
                                bl.close();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeMessage()));
                              } else {
                                print("password not valide");
                              }
                            } catch (e) {
                              print(e);
                             bl.close();
                             var wrong = await Constante.getAlert(context,Icon(Icons.warning_rounded));
                            wrong.style(
                                message:"Email ou mot de passe incorrect vieillez reessayez",
                                backgroundColor: Colors.blue,
                                messageTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w600));
                           
                            wrong.display();
                              Future.delayed(Duration(seconds: 2))
                                  .whenComplete(() {
                                wrong.close();
                              });
                            }
                          } else {
                            print("model not valid");
                          }
                        }),
                        Container(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              AuthMethods().signInWithGoogle(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.g_translate,
                                    size: 40, color: Constante.KPrimaryColor),
                                Text(
                                  "se connecter avec google",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Constante.KPrimaryColor),
                                ),
                              ],
                            )),
                        Container(
                          height: 2,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                  fontSize: 20, color: Constante.KPrimaryColor),
                            )),
                        Container(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                }))));
  }
}

class homeImg extends StatelessWidget {
  const homeImg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: CircleAvatar(
        minRadius: 20,
        maxRadius: 100,
        backgroundColor: Constante.KPrimaryLightColor,
        child: Image.asset(
          "female-freelancer-working-on-project-3839583-3202977.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
