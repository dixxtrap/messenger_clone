import 'package:facebook/Providers/GroupProvider.dart';
import 'package:facebook/Providers/LoginProviders.dart';
import 'package:facebook/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (_, model, __) {
        return Form(
          key: model.keyForm,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16),
            child: Column(
              children: [
                RoundedInput(Icon(Icons.person), "Donner le nom de votre Groupe", (value) {
                  if (value != "") {
                    model.name = value;
                    print("username affected");
                    return null;
                  } else {
                    return "le nom n'existe pas ";
                  }
                }),
               
                
                
              ],
            ),
          ),
        );
      },
    );
  }
}
