import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Networking/networkinGroup.dart';
import 'package:facebook/Screens/DetailScreen.dart';

import 'package:flutter/material.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constante.dart';

// ignore: must_be_immutable
class OnRowAddContactToGroup extends StatelessWidget {
  Personne contact;
  Group group;
  OnRowAddContactToGroup(this.contact, this.group);
  @override
  Widget build(BuildContext context) {
    print(contact.picture);
    return ListTile(
      leading: CircularImageUser(urlImage: contact.picture, radius: 80),
      title: Text(contact.username,
          style: GoogleFonts.lato(fontWeight: FontWeight.w900)),
      subtitle: Text(contact.statut),
      onTap: () async {
        bool test;

        test = await NetworkingGroup.addGroupToUser(contact.id, group);

        if (test) {
          print("test=========================>" + test.toString());
          var wrong = await Constante.getAlert(context,Icon(Icons.how_to_reg_rounded));
          wrong.style(
              message:"L'utilisateur a été supprimer avec succés",
              backgroundColor: Colors.blue,
              messageTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600));
          
          wrong.display();
            Future.delayed(Duration(seconds: 2))
                .whenComplete(() {
              wrong.close();});
         
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
