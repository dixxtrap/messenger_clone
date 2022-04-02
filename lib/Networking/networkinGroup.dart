import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Group.dart';
import 'package:facebook/Models/Message.dart';
import 'package:facebook/Models/MessageGroup.dart';
import 'package:facebook/Models/personne.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class NetworkingGroup {
  //  ===?>   cREATE groupe
  static Future<Group> createGroup(Group g) async {
    bool test = false;

    g.id = randomAlphaNumeric(20);

    if (g.picture != null) {
      await FirebaseStorage.instance
          .ref("images/groupProfils/" + g.id)
          .putFile(File(g.picture));
      await FirebaseStorage.instance
          .ref("images/groupProfils/" + g.id)
          .getDownloadURL()
          .then((value) => g.picture = value);
    }
    print("==============>Ulr:========>" + g.picture);
    FirebaseFirestore.instance
        .collection("group")
        .doc(g.author)
        .collection("myGroupes")
        .doc(g.id)
        .set(g.toJson())
        .then((value) {
      print("=====================> add group to user");
      addGroupToUser(g.author, g).then((v) {
        test = true;
      });
    });
    if (test) {
      return g;
    } else {
      return null;
    }
  }

  //  ===?> Create message Group
  updateLastMesSend(String chatRoomId, MessageGroup mes) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(mes.toJson());
  }

//  ===?> Add Message Groupe
  Future<bool> addMessageGroup(
      Personne user, Group group, String content, PickedFile img) async {
    bool test = false;
    try {
      MessageGroup mes =
          MessageGroup(user.id, user.picture, content, Timestamp.now(), "");
      if (img != null) {
        await FirebaseStorage.instance
            .ref("images/ChatRoomImage/" + group.id)
            .putFile(File(img.path));
        await FirebaseStorage.instance
            .ref("images/ChatRoomImage/" + group.id)
            .getDownloadURL()
            .then((value) => mes.imgUrl = value);
      }
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(group.id)
          .collection("chat")
          .add(mes.toJson())
          .then((value) => test = true)
          .then((value) => updateLastMesSend(
                group.id,
                mes,
              ));
    } catch (e) {
      print(e);
    }

    return test;
  }

  // ===?> Add Groupe To User
  static Future<bool> addGroupToUser(
    String idUser,
    Group group,
  ) async {
    bool response;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(idUser)
          .collection("groupes")
          .doc(group.id)
          .set(group.toJson())
          .then((value) => response = true);
    } on FirebaseException catch (e) {
      print(e);
      response = false;
    }
    return response;
  }

  //  ===?> get group by id
  static Future<Group> getGroupById(String id) async {
    Group group;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) => {group = Group.fromJson(value)});
    return group;
  }

  // ===?> leave Groupe
  static Future<int> leaveGroup(Personne p, Group g) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(p.id)
        .collection("groupes")
        .doc(g.id)
        .delete()
        .then((value) {
      return 1;
    });
    return 0;
  }
}
