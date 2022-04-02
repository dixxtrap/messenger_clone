import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/helperFunction/shared_helper_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Networking {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Future<int> inscription(String email, String pwd, String userName,
      String name, String img) async {
    print("inscription");
    int test = 0;
    try {
      // auth.signInAnonymously(); permet d'avoir l'id du téléphone de l'utilsateur qui s'est inscrit sur firebase
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.toString().trim(), password: pwd.toString().trim());
      if (user == null) {
        print("user not exist ");
        return 0;
      } else {
        print("user exist ");
        test = 1;
        final firestroreInstance = FirebaseFirestore.instance;
        String urlImage = "";
        if (img != null) {
          await FirebaseStorage.instance
              .ref("images/groupProfils/" + user.user.uid)
              .putFile(File(img));
          await FirebaseStorage.instance
              .ref("images/groupProfils/" + user.user.uid)
              .getDownloadURL()
              .then((value) => urlImage = value);
        }

        print(urlImage);
        var contact = {
          "email": email,
          "username": userName,
          "name": name,
          "id": user.user.uid,
          "imgUrl": urlImage
        };
        firestroreInstance
            .collection("users")
            .doc(user.user.uid)
            .set(contact)
            .then((value) async {
          test = await connexion(email, pwd.toString().trim());
        });

        //saveUserToDatabase(email, pwd, userName, img);
        return test;
      }
    } catch (e) {
      return 0;
    }

    // get List All Contact
  }

  static getListAllPersonne(String id) async {
    var json;
    json = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isNotEqualTo: id);
    print("========================json===============");

    print(json.toString());
    return json;
  }

  static Future<int> connexion(String email, password) async {
    Personne p;
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    var userDetail = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.user.uid)
        .get()
        .then((value) {
      p = Personne.fromJson(value);
    });

    if (user != null) {
      var result = user.user;
      SharedPreferenceHelper().saveUserEmail(email);
      SharedPreferenceHelper().saveUserId(result.uid);
      SharedPreferenceHelper().saveUserDisplayName(p.username);
      SharedPreferenceHelper().saveUserProfileUrl(p.picture);

      return 1;
    } else {
      return 0;
    }
  }
}
