import 'package:facebook/Models/Message.dart';
import 'package:facebook/constante.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: must_be_immutable
class Memessage extends StatelessWidget {
  bool isMe;
  Message mes;
  Memessage({@required this.isMe ,@required this.mes});

  @override
  Widget build(BuildContext context) {
   
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: (isMe)?MainAxisAlignment.start:MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                     child: ClipPath(
                clipper: LowerNipMessageClipper((isMe)?MessageType.RECEIVE:MessageType.SEND),
                child: Container(
                  padding:EdgeInsets.all(4),
                 color: (isMe)?Constante.KPrimaryColor:Colors.indigo,
                  width: MediaQuery.of(context).size.width*0.8,
                  child:ListTile(
                    title: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        
                         (isMe)?Text("Vous"):Text(""),
                        Text(mes.content,
                  style: GoogleFonts.lato(
                      color: Colors.white,
    textStyle: Theme.of(context).textTheme.display1,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  ),
  ),
  
   ]

    ),
  subtitle: Row(
     mainAxisAlignment:MainAxisAlignment.end,
    children: [
   
    Text(Constante.getDatefromTimestamp(mes.dateTime)),
    Icon(Icons.check_circle_outline_outlined)
  ],),
                  ),
                ),
                ),),),
             
              ],
            ),
             (( mes.imgUrl != null && mes.imgUrl!="")?Container(
               alignment: (isMe)?Alignment.topLeft:Alignment.topRight,
    width:MediaQuery.of(context).size.width*0.8,
    height: 200,
    child:ClipRRect(
      
     borderRadius: BorderRadius.circular(20),
     child:Image.network(mes.imgUrl,fit: BoxFit.fill,)
    )
  ):Container()),],
        ),
      );
  
  }
}
