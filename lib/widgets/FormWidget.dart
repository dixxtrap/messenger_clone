import 'package:facebook/Providers/LoginProviders.dart';
import 'package:facebook/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProviders>(
      builder: (_, model, __) {
        return Form(
          key: model.keyForm,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16),
            child: Column(
              children: [
                RoundedInput(Icon(Icons.person), "Nom Complet", (value) {
                  if (value != "") {
                    model.username = value;
                    print("username affected");
                    return null;
                  } else {
                    return "le nom n'existe pas ";
                  }
                }),
                RoundedInput(Icon(Icons.person), "email", (value) {
                  if (value.contains("@")) {
                    model.email = value;
                    print(model.email);
                    print("email affected");
                    return null;
                  } else {
                    return "Email est incorrecte ";
                  }
                }),
                RoudedPasswordInput("password", (value) {
                  if (value.length > 6  ) {
                    model.password = value;
                   
                    
                    return null;
                  } else {
                   return "password must be between 6 and 10 character";
                  }
                }),
                RoudedPasswordInput("confirmPassWord", (value) {
                  if (value != model.password || value != "") {
                    return null;
                  } else {
                    return "twice password as not similar";
                  }
                  
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
