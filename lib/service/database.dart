import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  Future addUserToDB(String userId, Map<String, dynamic> data) {
    return instance.collection("users").doc(userId).set(data);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String userName) async {
    return instance
        .collection("users")
        .where("username", isEqualTo: userName)
        .snapshots();
  }

  getChatRoomIdByUserName(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0))
      return "$a\_\$b";
    else
      return "$b\_\$a";
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chat")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMesSend(String chatRoomId, Map lastMessageInfoMap) {
    return instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) {
    final snapShot = instance.collection("chatroom").doc(chatRoomId).get();
    if (snapShot != null) {
      return true;
    } else {
      return instance.collection("chatrooms").doc(chatRoomId).set(chatRoomInfoMap);
    }
  }
}
