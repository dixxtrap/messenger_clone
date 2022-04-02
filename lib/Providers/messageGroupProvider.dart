import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MessageGroupProvider extends ChangeNotifier {
  PickedFile _file;
  ImagePicker imagePicker = new ImagePicker();
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  String _content;

  getNewImage() async {
    file = await imagePicker.getImage(source: ImageSource.gallery);

    notifyListeners();
  }

   get file {
    return _file;
  }

  set file(value) {
    _file = value;
    notifyListeners();
  }

  get content {
    return _content;
  }

  set content(value) {
    _content = value;
    notifyListeners();
  }
}
