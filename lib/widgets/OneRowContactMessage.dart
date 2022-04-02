import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Screens/DetailScreen.dart';
import 'package:facebook/constante.dart';

import 'package:flutter/material.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OneRowContactMessage extends StatelessWidget {
  Personne contact;
  Personne current;
  OneRowContactMessage(this.contact, this.current);
  @override
  Widget build(BuildContext context) {
    print(contact.picture);
    return ListTile(
      hoverColor: Constante.KPrimaryLightColor,
      leading: CircularImageUser(urlImage: contact.picture, radius: 60),
      title: Text(contact.username,
          style: GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize:20)),
      subtitle: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Text(contact.statut),
          Text(contact.email)
        ],
      ),
      onTap: () async {
        bool test;

        test = await NetworkkingMessage()
            .createChatRoom(current.id, contact.id, {"content": ""});

        if (test) {
          print("test" + test.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(contact, current)));
        }
      },
    );

    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 10.0),
    //   child: GestureDetector(
    //     onTap: () async {
    //       bool test;
    //       print("contact" + contact.id);
    //       print("current:" + current.email);
    //       test=await  NetworkkingMessage().createChatRoom(
    //        current.id,contact.id,
    //           {"content": ""});
    //       if (test) {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) =>
    //                     DetailScreen(this.contact, this.current)));
    //       }
    //     },
    //     child: Row(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(right: 10.0),
    //           child: CircularImageUser(urlImage: contact.picture, radius: 60),
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               contact.username,
    //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Container(
    //               width: MediaQuery.of(context).size.width - 115,
    //               child: Text(
    //                 contact.statut,
    //                 style: TextStyle(
    //                   fontSize: 15,
    //                 ),
    //                 overflow: TextOverflow.ellipsis,
    //                 maxLines: 1,
    //               ),
    //             )
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
