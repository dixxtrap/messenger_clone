import 'package:facebook/Models/personne.dart';
import 'package:facebook/helperFunction/shared_helper_preference.dart';
import 'package:flutter/material.dart';

import 'OneRowContactMessage.dart';

// ignore: must_be_immutable
class ListViewAllContact extends StatelessWidget {
  List<Personne> allContact;
  Personne current;
  ListViewAllContact(this.allContact, this.current);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {

          return OneRowContactMessage(allContact[index], this.current);
        },
        separatorBuilder:  (context, index) => Divider(
        color: Colors.black,
        thickness: 0.3,
      ),
        itemCount: allContact.length);
    //   (
    //   itemBuilder: (BuildContext context, int index) {
    //     return OneRowContactMessage(allContact[index],this.current);
    //   },
    //   itemCount: allContact.length,

    // );
  }
}
