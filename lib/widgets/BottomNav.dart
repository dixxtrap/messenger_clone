import 'package:facebook/Screens/ChatRooms.dart';
import 'package:facebook/Screens/GroupeScreen.dart';
import 'package:facebook/Screens/HomeMessage.dart';
import 'package:facebook/constante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  int currentIndex;
   BottomNav(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Constante.KPrimaryColor,
      currentIndex: this.currentIndex,
      backgroundColor: Constante.KPrimaryLightColor,
      iconSize: 10,
      selectedIconTheme: IconThemeData(color:Constante.KPrimaryColor),
     showUnselectedLabels:true,
     showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          

          icon: IconButton(
              icon: Icon(Icons.contact_mail, ),
              
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeMessage()));
              }),
          label: "Contacts",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(
                Icons.group_outlined,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GroupScreen()));
              }),
          label: "Groupes",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              icon: Icon(Icons.message),
               onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ChatRommsScreen()));
              }),
          label: "Messages",
        )
      ],
    );
  }
}
