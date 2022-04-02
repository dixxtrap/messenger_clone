import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class LoginProviders extends ChangeNotifier {
  PickedFile file;
  ImagePicker imagePicker = new ImagePicker();
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _username;
  String _name;

  getNewImage() async {
    file = await imagePicker.getImage(source: ImageSource.gallery);

    notifyListeners();
  }

  get name {
    return _name;
  }

  get email {
    return _email;
  }

  get password {
    return _password;
  }

  get username {
    return _username;
  }

  set password(value) {
    _password = value;
    notifyListeners();
  }
  set name(value){
    _name = value;
    notifyListeners();
  }
  set email(value) {
    _email = value;
    notifyListeners();
  }

  set username(value) {
    _username = value;
    notifyListeners();
  }
}
