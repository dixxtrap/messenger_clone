
import 'package:facebook/Models/personne.dart';


import '../helperFunction/shared_helper_preference.dart';


class Methods {
  static Future<Personne> getMyInfoFromSharedPreference() async {
    String myId = await SharedPreferenceHelper().getUserId();
    String myName = await SharedPreferenceHelper().getDisplayName();
    String myProfilePicture =
        await SharedPreferenceHelper().getUserProfileUrl();
    String myUsername = await SharedPreferenceHelper().getUserName();
    String myEmail = await SharedPreferenceHelper().getUserEmail();
    return Personne(myId, myName, myProfilePicture, myEmail, myUsername,"status");
  }
  static String getChatRoomIdByUserName(String a ,String b) {
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0))
      return "$a\_$b"; 
    else return "$b\_$a";
}
}


