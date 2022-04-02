import 'dart:io';

import 'package:facebook/Providers/LoginProviders.dart';
import 'package:facebook/constante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePIckerWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProviders>(
      builder: (_, loginProvider, __) {
        return GestureDetector(
            onTap: () async {
              loginProvider.getNewImage();
            },
            child: loginProvider.file != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(loginProvider.file.path)),
                    radius: 50,
                    
                  )
                : CircleAvatar(
                    radius: 50,
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
