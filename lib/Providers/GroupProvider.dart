import 'package:facebook/Models/personne.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class GroupProvider extends ChangeNotifier {
  PickedFile file;
  ImagePicker imagePicker = new ImagePicker();
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  String _name;
  List<Personne> selectedUser;

  getNewImage() async {
    file = await imagePicker.getImage(source: ImageSource.gallery);

    notifyListeners();
  }

  get name {
    return _name;
  }

  set name(value) {
    _name = value;
    notifyListeners();
  }
}
