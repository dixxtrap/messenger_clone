import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/personne.dart';
import 'package:facebook/Screens/HomeMessage.dart';
import 'package:facebook/Screens/signin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../helperFunction/shared_helper_preference.dart';
import '../service/database.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
// get Current User
  getCurrentUser() async {
    return auth.currentUser;
  }

// Sugn in with Password and Email
  Future<int>signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Personne user;
     await  FirebaseFirestore.instance.collection("users").doc(result.user.uid).get().then((value) => {
        user=Personne.fromJson(value)
      });
      // ===> on sauvegarder l'utilisateur 
       SharedPreferenceHelper().saveUserEmail(user.email);
      SharedPreferenceHelper().saveUserId(result.user.uid);
      SharedPreferenceHelper().saveUserDisplayName(user.username);
      SharedPreferenceHelper().saveUserName(user.name);

      SharedPreferenceHelper().saveUserProfileUrl(user.picture);

      return 1;
    } on FirebaseAuthException catch (e) {
      return 0;
    }
  }

//  Sign Up With Email and Password


  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user;
    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserName(userDetails.displayName);

      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

      Map<String, dynamic> userInfoMap = {
        "id": userDetails.uid,
        "email": userDetails.email,
        "username": userDetails.email.replaceAll("@gmail.com", ""),
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL
      };

      DatabaseMethods().addUserToDB(userDetails.uid, userInfoMap).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeMessage()));
      });
    }
  }

  saveUser(User userDetails) {
    SharedPreferenceHelper().saveUserEmail(userDetails.email);
    SharedPreferenceHelper().saveUserId(userDetails.uid);
    SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName);
    SharedPreferenceHelper().saveUserName(userDetails.displayName);
    SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);
  }

  addSimpleUserDetails(
      BuildContext context, String id, String email, String imgUrl) {
    Map<String, dynamic> userInfoMap = {
      "email": email,
      "username": email.replaceAll("@gmail.com", ""),
      "imgUrl": imgUrl,
      "status": '0'
    };

    // DatabaseMethods().addUserToDB(id, userInfoMap).then((value) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => HomeMessage()));
    // });
  }

  addUserDetails(BuildContext context, User userDetails) {
    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL
    };

    DatabaseMethods().addUserToDB(userDetails.uid, userInfoMap).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeMessage()));
    });
  }

  signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut().then((value) => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignIn()))
        });
  }
}
