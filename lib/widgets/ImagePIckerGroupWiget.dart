import 'dart:io';


import 'package:facebook/Providers/MessqgeProvider.dart';
import 'package:facebook/Providers/messageGroupProvider.dart';
import 'package:facebook/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePIckerGroupWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageGroupProvider>(
      builder: (_, messageProvider, __) {
        return GestureDetector(
            onTap: () async {
              messageProvider.getNewImage();
            },
            child: messageProvider.file != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(messageProvider.file.path)),
                    radius: 25,
                    
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: Constante.KPrimaryLightColor,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 25,
                      color:Constante.KPrimaryColor,
                    ),
                  ));
      },
    );
  }
}
