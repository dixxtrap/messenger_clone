import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MessageProvider extends ChangeNotifier {
  PickedFile _file;
  ImagePicker imagePicker = new ImagePicker();
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  String _content;

  getNewImage() async {
    file = await imagePicker.getImage(source: ImageSource.gallery);

    notifyListeners();
  }

  get content {
    return _content;
  }
  get file {
    return _file;
  }

  set file(value) {
    _file = value;
    notifyListeners();
  }

  set content(value) {
    _content = value;
    notifyListeners();
  }
}
