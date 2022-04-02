

import 'package:facebook/Providers/LoginProviders.dart';

import 'package:facebook/widgets/FormWidget.dart';


import 'package:facebook/widgets/ImagePickerWidget.dart';
import 'package:facebook/widgets/LoginButton.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constante.dart';

class LoginScreen extends StatelessWidget {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProviders(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,

          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Constante.KPrimaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          title: Text(
            "SignIn",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
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
      ),
    );
  }
}
