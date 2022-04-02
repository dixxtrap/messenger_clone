import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Screens/DetailScreen.dart';

import 'package:flutter/material.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OneRowContactGroup extends StatelessWidget {
  Personne contact;

  OneRowContactGroup(
    this.contact,
  );
  @override
  Widget build(BuildContext context) {
    print(contact.picture);
    return ListTile(
      selected: true,
      leading: CircularImageUser(urlImage: contact.picture, radius: 80),
      title: Text(contact.username,
          style: GoogleFonts.lato(fontWeight: FontWeight.w900)),
      subtitle: Text(contact.statut),
      onTap: () async {},
    );
  }
}
