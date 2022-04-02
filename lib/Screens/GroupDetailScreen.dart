import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/Message.dart';
import 'package:facebook/Models/chatRoom.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Networking/networkinGroup.dart';
import 'package:facebook/Providers/MessqgeProvider.dart';
import 'package:facebook/Providers/messageGroupProvider.dart';
import 'package:facebook/Screens/GroupeScreen.dart';
import 'package:facebook/constante.dart';
import 'package:facebook/widgets/BottomGroupWidget.dart';
import 'package:facebook/widgets/BottomWidget.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:facebook/widgets/ListViewAllContact.dart';
import 'package:facebook/widgets/ListViewAllContactToAddGroup.dart';
import 'package:facebook/widgets/Memessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore: must_be_immutable
class DetailGroupScreen extends StatefulWidget {
  Personne current;
  Group group;

  DetailGroupScreen(this.current, this.group);

  @override
  _DetailGroupScreenState createState() => _DetailGroupScreenState();
}

class _DetailGroupScreenState extends State<DetailGroupScreen> {
  var mes;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mes;
    String chatRoomId = widget.group.id;

    return ChangeNotifierProvider(
        create: (context) => MessageGroupProvider(),
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Constante.KPrimaryColor,
            backgroundColor: Constante.KPrimaryLightColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constante.KPrimaryColor,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: false,
            title: Row(
              children: [
                Container(
                    child: Expanded(
                  child: CircularImageUser(
                      urlImage: widget.group.picture, radius: 50),
                )),
                SizedBox(
                  width: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.widget.group.name,
                      style: TextStyle(
                          fontSize: 15,
                          color: Constante.KPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "En ligne",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.message_rounded,
                      color: Constante.KPrimaryColor, size: 30),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return listUser(widget.current);
                      },
                    );
                  }),
              (widget.group.author == widget.current.id)
                  ? IconButton(
                      icon: Icon(Icons.person_add,
                          color: Constante.KPrimaryColor, size: 30),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return listAddUser(widget.group, widget.current);
                          },
                        );
                      })
                  : IconButton(
                      icon: Icon(Icons.remove_done,
                          color: Constante.KPrimaryColor, size: 30),
                      onPressed: () async {
                        int test = await NetworkingGroup.leaveGroup(
                            widget.current, widget.group);
                        if (test == 1) {
                          var wrong = await Constante.getAlert(
                              context, Icon(Icons.done_all));
                          wrong.style(
                              message: "vous avez quiter le group",
                              backgroundColor: Colors.blue,
                              messageTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600));

                          wrong.display();
                          Future.delayed(Duration(seconds: 2)).whenComplete(() {
                            wrong.close();
                            Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GroupScreen()));
                          });
                        }
                      })
            ],
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatrooms")
                  .doc(chatRoomId)
                  .collection("chat")
                  .orderBy("dateTime", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Message> myList = [];
                  Message m;
                  print(snapshot.data.docs);
                  print("le if");
                  for (var item in snapshot.data.docs) {
                    print(item);
                    print("le for");

                    myList.add(Message.fromJson(item.data()));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, int position) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Memessage(
                              isMe: NetworkkingMessage.isMe(
                                  myList[position].sendBy, widget.current.id),
                              mes: myList[position]),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("Something is wrong");
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          bottomSheet: BottomGroupWidget(widget.current, widget.group),
        ));
  }
}

class listUser extends StatelessWidget {
  final Personne current;
  const listUser(this.current);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (_, controller) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Constante.KPrimaryColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                      ),
                      height: 10,
                      width: 100,
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    color: Colors.white,
                    child: Row(children: [
                      Text("ENvoyer des Message Priver",
                          style: GoogleFonts.lato(
                              fontSize: 22, color: Constante.KPrimaryColor))
                    ]),
                  ),
                  Text("Avanr StremBuilder"),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("id", isNotEqualTo: current.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(
                            "==============================list user=================");
                        List<Personne> myListUser = [];
                        if (snapshot.hasData) {
                          Message m;
                          print(snapshot.data.docs);
                          print("le if");
                          for (var item in snapshot.data.docs) {
                            print(item);
                            print("le for");

                            myListUser.add(Personne.fromJson(item.data()));
                          }
                          print(myListUser.length);
                          return Expanded(
                              child: Container(
                                  child:
                                      ListViewAllContact(myListUser, current)));
                        } else if (snapshot.hasError) {
                          return Text("Something is wrong");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                ],
              ),
            ),
          );
        });
  }
}

class listAddUser extends StatelessWidget {
  final Group group;
  final Personne current;
  const listAddUser(this.group, this.current);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (_, controller) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              color: Constante.KPrimaryLightColor,
              child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Constante.KPrimaryColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                      ),
                      height: 10,
                      width: 100,
                    )),
                  ),
                  Text("Avanr StremBuilder"),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("id", isNotEqualTo: current.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(
                            "==============================list user=================");
                        List<Personne> myListUser = [];
                        if (snapshot.hasData) {
                          Message m;
                          print(snapshot.data.docs);
                          print("le if");
                          for (var item in snapshot.data.docs) {
                            print(item);
                            print("le for");

                            myListUser.add(Personne.fromJson(item.data()));
                          }
                          print(myListUser.length);
                          return Expanded(
                              child: Container(
                                  child: ListViewAllContactToAddGroup(
                                      myListUser, group)));
                        } else if (snapshot.hasError) {
                          return Text("Something is wrong");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                ],
              ),
            ),
          );
        });
  }
}
