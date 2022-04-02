import 'package:facebook/Providers/GroupProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'FormWidget.dart';
import 'ImagePickerWidget.dart';
import 'LoginButton.dart';

class GroupWidget extends StatefulWidget {
  GroupWidget();

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GroupProvider()),
      ],
    child: Container(
       child:Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                height:60,
                  ),
                  ImagePIckerWiget(),
                  FormWidget(),
                  LoginButton(),
                ],
              )
            ],
          ),
        ),
    ));
  }
}