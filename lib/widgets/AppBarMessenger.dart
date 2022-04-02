import 'package:flutter/material.dart';

import 'CircularImageUser.dart';

class AppBarMessenger extends StatelessWidget {
  final double radius = 50;

  @override
  Widget build(BuildContext context) {
    //SafeArea est widget qui insage son child par un remplissage 
    //suffisant pour eviter les intrusions du systeme d'exploitation
    //c'est à dire qu'il identera suffisamment pour eviter la barre d'etat en haut de l'ecran
    return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0,left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularImageUser(
                  urlImage:"https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-1/p200x200/121966405_2553628024762281_7483476502532829451_o.jpg?_nc_cat=100&ccb=1-3&_nc_sid=7206a8&_nc_eui2=AeHXq-RhWaD4rQSkXHEXqqwkaaKUP1l68vhpopQ_WXry-Ocqb6QV6kf12BC7JJsIq7KdkIz13AT3mEReBcdd1dkq&_nc_ohc=LJXKoo_0CyMAX9DOaP6&_nc_ht=scontent-mrs2-1.xx&tp=6&oh=6f6224255c11e8b8b7b60244c462be13&oe=60876691",
                  radius :radius ),
                  Text("Messenger",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20,fontStyle: FontStyle.italic,),),
                  IconButton(icon: Icon(Icons.edit),
                  onPressed: (){

                 })
              ],
            ),
        
      ),
    );
  }
}