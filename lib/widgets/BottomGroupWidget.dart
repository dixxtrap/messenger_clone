import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Networking/networkinGroup.dart';
import 'package:facebook/Providers/MessqgeProvider.dart';
import 'package:facebook/Providers/messageGroupProvider.dart';
import 'package:facebook/constante.dart';
import 'package:facebook/widgets/ImagePIckerGroupWiget.dart';
import 'package:facebook/widgets/ImagePickerMessageWidget.dart';
import 'package:facebook/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomGroupWidget extends StatelessWidget {
  Personne sendBy;
  Group group;
  BottomGroupWidget(this.sendBy, this.group);
  @override
  Widget build(BuildContext context) {
    TextEditingController t = TextEditingController();
    return Consumer<MessageGroupProvider>(builder: (_, model, __) {
      return Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    ImagePIckerGroupWiget(),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.keyboard_voice,
                      size: 25,
                      color: Constante.KPrimaryColor,
                    )
                  ],
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width) / 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 40,
                        child: Expanded(
                          child: Form(
                            key: model.keyForm,
                            child: RoundedInputMessage("Message", (value) {
                              model.content = value;
                              t.text = "";
                              return null;
                            }, t),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.send,
                          size: 30, color: Constante.KPrimaryColor),
                      onPressed: () async {
                        if (model.keyForm.currentState.validate()) {
                          print("============================file===========");
                         
                          bool test = await NetworkingGroup().addMessageGroup(
                              sendBy, group, model.content, model.file);
                          if (test) {
                            print("message envoyer");
                            model.file = null;
                          } else
                            print("message non envoyer");
                        } else {
                          print("form not valid");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
