import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Screens/GroupDetailScreen.dart';
import 'package:facebook/constante.dart';


import 'package:flutter/material.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OneRowGroup extends StatelessWidget {
  Group group;
  Personne current;
  OneRowGroup(this.group, this.current);
  @override
  Widget build(BuildContext context) {
    print("========== onRow Group ==========");
    print(group.picture);
    return ListTile(
      leading: CircularImageUser(urlImage: group.picture, radius: 80),
      title: Text(group.name,
          style: GoogleFonts.lato(fontWeight: FontWeight.w900)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text(Constante.getDatefromTimestamp(group.dateTime) )]),

      onTap: () async {
        bool test;
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailGroupScreen(current, group)));
      },
    );
  }
}
