import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Message.dart';
import 'package:facebook/Models/chatRoom.dart';
import 'package:facebook/Models/personne.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class NetworkkingMessage {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  Future<Stream<QuerySnapshot>> getUserByUserName(String userName) async {
    return instance
        .collection("users")
        .where("username", isEqualTo: userName)
        .snapshots();
  }

 Future<Personne> getUserById(String id) async {
    Personne p;
    FirebaseFirestore.instance.collection("user").doc(id).get().then((value) {
      p = Personne.fromJson(value);
    });
    return p;
  }

  static bool isMe(String id, String currentId) {
    return id == currentId;
  }

  Future<bool> addMessage(
      Personne user, Personne contact, String content,PickedFile img) async {
    bool test = false;

    String chatRoomId = ChatRoom.getChatRoomIdByUserName(user.id, contact.id);
    
    try {
     

      ChatRoom chat = ChatRoom(user.picture, contact.picture, Timestamp.now());
      Message  mes = Message(user.id, contact.id, content, Timestamp.now(),"");
      if (img != null) {
       
      await FirebaseStorage.instance
          .ref("images/ChatRoomImage/"+chatRoomId)
          .putFile(File(img.path));
      await FirebaseStorage.instance
          .ref("images/ChatRoomImage/"+chatRoomId)
          .getDownloadURL()
          .then((value) => mes.imgUrl=value);
    }
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .collection("chat")
        .add(mes.toJson())
          .then((value) => test = true)
          .then((value) => updateLastMesSend(
                chatRoomId,
                chat,
                mes,
              ));
      if (test == true) {
        updateLastMesSend(chatRoomId, chat, mes);
      }
    } catch (e) {
      print(e);
    }

    return test;
  }

  updateLastMesSend(String chatRoomId, ChatRoom chatRoom, Message mes) {
    Map<String, dynamic> map = getlastmessageInfo(chatRoom, mes);
    return instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(mes.toJson());
  }

  Future<bool> createChatRoom(
      String sendBy, String sendTo, Map chatRoomInfoMap) async {
    bool test = false;
    String chatRoomId = ChatRoom.getChatRoomIdByUserName(sendBy, sendTo);
    Map<String, dynamic> defaultMap;

    try {
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .get()
          .then((doc) {
        if (doc.exists)
          test = true;
        else
          test = false;
      });

      if (test) {
        return true;
      } else {
        defaultMap = {"content": "pas de dicussion"};
        print("dans le else");
        await FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(chatRoomId)
            .set(defaultMap)
            .then((value) => test = true);
        if (test) print("chatRoom creer 2");
      }
      print(test);
      return test;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getlastmessageInfo(ChatRoom chatRoom, Message message) {
    Map<String, dynamic> map = {
      "sendByUrl": chatRoom.sendByUrl,
      "sendToUrl": chatRoom.sendToUrl,
      "content": message.content,
      "datetime": message.dateTime
    };
    return map;
  }

  Stream<List<Message>> getData(String chatRoomId) async* {
    var messagesStream = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .collection('chat')
        .orderBy("timestamp", descending: true)
        .snapshots();
    List<Message> messages;
    await for (var messagesSnapshot in messagesStream) {
      for (var messageDoc in messagesSnapshot.docs) {
        var mes = Message.fromJson(messageDoc);
        messages.add(mes);
      }
      yield messages;
    }
  }
}
