import 'package:cloud_firestore/cloud_firestore.dart';

class MessageGroup {
  String sendBy;
  String sendByUrl;
  //TODO:envoyer un image
  String imgUrl;
  Timestamp dateTime;
  String content;

  MessageGroup(
      this.sendBy, this.sendByUrl, this.content, this.dateTime, this.imgUrl);
  MessageGroup.fromJson(dynamic obj) {
    this.sendBy = obj["sendBy"];
    this.sendByUrl = obj["sendByUrl;"];

    this.content = obj["content"];
    this.imgUrl = obj["imgUrl"];
    this.dateTime = obj["dateTime"];
  }
  Map<String, dynamic> toJson() {
    return {
      "sendBy": this.sendBy,
      "sendByUrl": this.sendByUrl,
      "dateTime": this.dateTime,
      "imgUrl": this.imgUrl,
      "content":this.content,
    };
  }
}
