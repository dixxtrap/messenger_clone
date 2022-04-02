import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  String sendByUrl;
  String sendToUrl;
  Timestamp dateTime;
  String content;
  String id;
  static getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return a + "_" + b;
    } else
      return b + "_" + a;
  }

  ChatRoom(this.sendByUrl, this.sendToUrl, this.dateTime) {}
  ChatRoom.fromJson(dynamic obj) {
    sendByUrl = obj["sendBy"];
    sendToUrl = obj["sendTo"];
    dateTime = obj["datetime"];
    content = obj["content"];
  }
  Map<String, dynamic> toJson() {
    return {
      "sendBy": this.sendByUrl,
      "sendTo": this.sendToUrl,
      "dateTime": this.dateTime,
      "content":this.content
    };
  }
}
