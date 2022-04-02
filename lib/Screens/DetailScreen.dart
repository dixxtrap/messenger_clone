import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Message.dart';
import 'package:facebook/Models/chatRoom.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Networking/NetworkingMessage.dart';
import 'package:facebook/Providers/MessqgeProvider.dart';
import 'package:facebook/constante.dart';
import 'package:facebook/widgets/BottomWidget.dart';
import 'package:facebook/widgets/CircularImageUser.dart';
import 'package:facebook/widgets/Memessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  Personne user;
  Personne current;

  DetailScreen(this.user, this.current);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var mes;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mes;
    String chatRoomId =
        ChatRoom.getChatRoomIdByUserName(widget.current.id,widget.user.id);

    return ChangeNotifierProvider(
        create: (context) => MessageProvider(),
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Constante.KPrimaryColor,
            backgroundColor: Constante.KPrimaryLightColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Constante.KPrimaryColor,size:30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                SizedBox(
                  width: 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.user.username,
          style: GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize:20,
          color:Constante.KPrimaryColor)),
                    Text(
                      "En ligne",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                ),
              Container(
                    padding: EdgeInsets.symmetric(),
                    child: Expanded(
                      child: CircularImageUser(
                          urlImage: widget.user.picture, radius: 42),
                    )),],
            ),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatrooms")
                  .doc(chatRoomId)
                  .collection("chat").orderBy("dateTime",descending: false)
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
                          padding: const EdgeInsets.only(bottom:50),
                          child: Memessage(
                              isMe:NetworkkingMessage.isMe(myList[position].sendBy,widget.current.id),
                              mes:myList[position]),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("Something is wrong");
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          bottomSheet: BottomWidget(widget.current, widget.user),
        ));
  }
}
