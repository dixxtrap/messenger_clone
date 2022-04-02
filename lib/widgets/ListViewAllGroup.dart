import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/helperFunction/shared_helper_preference.dart';
import 'package:facebook/widgets/OneRowGroup.dart';
import 'package:flutter/material.dart';

import 'OneRowContactMessage.dart';

// ignore: must_be_immutable
class ListViewAllGroup extends StatelessWidget {
  List<Group> allGroup;
  Personne current;
  ListViewAllGroup(this.allGroup, this.current);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          print("=======================index==============" + index.toString());
          return OneRowGroup(allGroup[index], this.current);
        },
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
        itemCount: allGroup.length);
    //   (
    //   itemBuilder: (BuildContext context, int index) {
    //     return OneRowContactMessage(allContact[index],this.current);
    //   },
    //   itemCount: allContact.length,

    // );
  }
}
