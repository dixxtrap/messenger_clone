import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/personne.dart';

import 'package:facebook/constante.dart';
import 'package:facebook/helperFunction/shared_helper_preference.dart';
import 'package:facebook/service/auth.dart';
import 'package:facebook/widgets/BottomNav.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:facebook/widgets/ListViewAllGroup.dart';

import 'package:flutter/material.dart';

import 'package:facebook/widgets/CustomTextField.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  Personne current;
  var user;
  Future<int> dothisOnLauch() async {
    await SharedPreferenceHelper()
        .getInfoFromSharedPreference()
        .then((value) => {current = value});
    print("==================id :" + current.id + "==================");
    user = await FirebaseFirestore.instance
        .collection("users")
        .doc(current.id)
        .collection("groupes");
    print(user);
    return 1;
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dothisOnLauch(),
        builder: (context, snapshot) {
          return Scaffold(
              bottomNavigationBar: BottomNav(1),
              appBar: snapshot.hasData
                  ? AppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Constante.KPrimaryColor,
                      leading: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularImageUser(
                              urlImage: current.picture, radius: 12)),
                      title: Text(
                        "Groupes",
                        style: TextStyle(color: Constante.KPrimaryColor),
                      ),
                      elevation: 0,
                      centerTitle: true,
                      actions: [
                          IconButton(
                              icon: Icon(Icons.group_add_rounded),
                              color: Constante.KPrimaryColor,
                              tooltip: "Ajouter un Groupe",
                              iconSize: 30,
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.logout),
                              color: Constante.KPrimaryColor,
                              iconSize: 30,
                              tooltip: "Deconnexion",
                              onPressed: () {
                                AuthMethods().signOut(context);
                              }),
                        ])
                  : AppBar(),
              body: snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(), // voir definition
                          SizedBox(
                            height: 30,
                          ),

                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: user.snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Some error");
                                    } else if (snapshot.hasData) {
                                      List<Group> allContact = [];
                                      print(
                                          "================la taile de la list==========");
                                      print(snapshot.data.docChanges.length);
                                      print(
                                          "============after boucle===============");
                                      for (var doc
                                          in snapshot.data.docChanges) {
                                        print(
                                            '==================for boucle============');
                                        allContact.add(
                                            Group.fromJson(doc.doc.data()));
                                      }
                                      print(
                                          "================taille de la list after insertion=============");
                                      print(allContact.length);
                                      return ListViewAllGroup(
                                          allContact, this.current);
                                    } else {
                                      return Expanded(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()));
                                    }
                                  }) // voir definition
                              )
                        ],
                      ),
                    )
                  : Center(
                      child: Text("loading"),
                    ));
        });
  }
}
