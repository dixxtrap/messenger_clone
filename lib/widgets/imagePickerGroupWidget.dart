import 'dart:io';

import 'package:facebook/Providers/GroupProvider.dart';
import 'package:facebook/Providers/LoginProviders.dart';
import 'package:facebook/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePIckerGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (_, loginProvider, __) {
        return GestureDetector(
            onTap: () async {
              loginProvider.getNewImage();
            },
            child: loginProvider.file != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(loginProvider.file.path)),
                    radius: 80,
                    
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundColor: Constante.KPrimaryLightColor,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                      color:Constante.KPrimaryColor,
                    ),
                  ));
      },
    );
  }
}
