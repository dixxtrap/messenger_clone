import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SignInProvider extends ChangeNotifier {
  String email;
  String password;

  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();

  setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
