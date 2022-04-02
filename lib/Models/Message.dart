import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String sendBy;
  String sendTo;
  //TODO:envoyer un image
  String imgUrl;
  Timestamp dateTime;
  String content;
  

  Message(this.sendBy, this.sendTo,this.content, this.dateTime ,this.imgUrl);
  Message.fromJson(dynamic obj) {
    this.sendBy = obj["sendBy"];
    this.sendTo = obj["sendTo"];
    this.dateTime = obj["dateTime"];
    this.content = obj["content"];
    this.imgUrl=obj["imgUrl"];
  }
  Map<String, dynamic> toJson() {
    return {
      "sendBy":this.sendBy,
      "sendTo":this.sendTo, 
      "dateTime":this.dateTime,
      "imgUrl":this.imgUrl , 
      "content":this.content
    };
  }
  
}
