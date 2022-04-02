import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Group {
  String id;
  String author;
  String name;
  Timestamp dateTime;
  String picture;

  Group(this.id, this.author, this.name, this.picture, this.dateTime);
  Group.fromJson(dynamic obj) {
    id = obj["id"];
    author = obj["author"];
    picture = obj["pictureUrl"];
    name=obj["name"];
    dateTime = obj["dateTime"];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "author": this.author,
      "name": this.name,
      "pictureUrl": this.picture,
      "dateTime": Timestamp.fromDate(DateTime.now()),
    };
  }

 
}
