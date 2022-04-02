import 'package:backdrop_modal_route/backdrop_modal_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/Models/Group.dart';
import 'package:facebook/Networking/networkinGroup.dart';
import 'package:facebook/Providers/GroupProvider.dart';
import 'package:facebook/Screens/GroupDetailScreen.dart';
import 'package:facebook/widgets/FormWidget.dart';
import 'package:facebook/widgets/GroupWidget.dart';
import 'package:facebook/widgets/formGroupWidget.dart';
import 'package:facebook/widgets/imagePickerGroupWidget.dart';
import 'package:facebook/widgets/roundedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';

import 'Models/personne.dart';

mixin Constante {
  static const KPrimaryColor = Color(0xff6f35a5);
  static const KPrimaryLightColor = Color(0xfff1e6ff);
  static getAlert(BuildContext context, Widget load) {
    return new BottomLoader(context,
        isDismissible: true, showLogs: true, loader: load);
  }

  static void handleStatelessBackdropContent(
      BuildContext context, Personne author) async {
    final result = await Navigator.push(
      context,
      BackdropModalRoute<String>(
        overlayContentBuilder: (context) =>
            StatelessBackdropOverlayContent(author),
      ),
    );
  }

  static getDatefromTimestamp(Timestamp t) {
    String s;
    Jiffy.locale("fr");
    DateTime dt = t.toDate();

    s = Jiffy({
      "year": dt.year,
      "month": dt.month,
      "day": dt.day,
      "hour": dt.hour,
      "minute": dt.minute
    }).yMMMMEEEEdjm;
    return s;
    // dt.day.toString() + "-" + dt.month.toString() + "-" + dt.year.toString();
  }

  static getScreen(BuildContext context, Widget child) async {
    return await Navigator.push(
      context,
      BackdropModalRoute<void>(
        overlayContentBuilder: (context) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24),
            child: child,
          );
        },
      ),
    );
  }
}

class StatelessBackdropOverlayContent extends StatefulWidget {
  final Personne author;

  StatelessBackdropOverlayContent(this.author);

  @override
  _StatelessBackdropOverlayContentState createState() =>
      _StatelessBackdropOverlayContentState();
}

class _StatelessBackdropOverlayContentState
    extends State<StatelessBackdropOverlayContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GroupProvider()),
        ],
        child: Column(
          children: [
            Container(
              color: Constante.KPrimaryLightColor,
              child: ListTile(
                title: Text("Creer un Groupe",
                    style: GoogleFonts.lato(
                      fontSize: 22,
                    )),
                trailing: IconButton(
                  icon: Icon(
                    Icons.backspace_outlined,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              height: 40,
            ),
            ImagePIckerGroupWidget(),
            FormGroupWidget(),
            Consumer<GroupProvider>(builder: (_, model, __) {
              return RoundedButton("Creer le Groupe", () async {
                if (model.keyForm.currentState.validate()) {
                  print("===================avant l'insertion==============");
                  Group g = Group(
                    "",
                    widget.author.id,
                    model.name,
                    model.file.path,
                    Timestamp.fromDate(DateTime.now()),
                  );
                  print(g.picture);
                  g = await NetworkingGroup.createGroup(g);
                  if (g != null) {
                    print("==============dand le if g exist===============");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailGroupScreen(widget.author.id, g)));
                  } else {
                    Navigator.pop(context);
                  }
                  print("form valid");
                } else {
                  Navigator.pop(context);
                  print("form not valid");
                }
              });
            })
          ],
        ),
      ),
    );
  }
}
