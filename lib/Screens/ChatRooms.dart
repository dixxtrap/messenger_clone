import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Screens/GroupeScreen.dart';
import 'package:facebook/Screens/HomeMessage.dart';

import 'package:facebook/constante.dart';
import 'package:facebook/helperFunction/shared_helper_preference.dart';
import 'package:facebook/service/auth.dart';
import 'package:facebook/widgets/BottomNav.dart';
import 'package:facebook/widgets/CircularImageUser.dart';

import 'package:flutter/material.dart';

import 'package:facebook/widgets/CustomTextField.dart';
import 'package:facebook/widgets/ListViewAllContact.dart';

class ChatRommsScreen extends StatefulWidget {
  @override
  _ChatRommsScreenState createState() => _ChatRommsScreenState();
}

class _ChatRommsScreenState extends State<ChatRommsScreen> {
  Personne current;
  var user;
  Future<int> dothisOnLauch() async {
    await SharedPreferenceHelper()
        .getInfoFromSharedPreference()
        .then((value) => {current = value});
    print(current);
    user = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isNotEqualTo: current.email);
    return 1;
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    dothisOnLauch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dothisOnLauch(),
        builder: (context, snapshot) {
          return Scaffold(
              bottomNavigationBar: BottomNav(2),
              appBar: snapshot.hasData
                  ? AppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Constante.KPrimaryColor,
                      leading: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularImageUser(
                              urlImage: current.picture, radius: 12)),
                      title: Text(
                        "Messages",
                        style: TextStyle(color: Constante.KPrimaryColor),
                      ),
                      elevation: 0,
                      centerTitle: true,
                      actions: [
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
                                      List<Personne> allContact = [];
                                      print("after boucle");
                                      for (var doc
                                          in snapshot.data.docChanges) {
                                        print('for boucle');
                                        allContact.add(
                                            Personne.fromJson(doc.doc.data()));
                                      }
                                      return ListViewAllContact(
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

