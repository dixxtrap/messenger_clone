import 'package:flutter/foundation.dart';

class Switching extends ChangeNotifier {
  static bool _isSearching = false;
  static bool _waitUser = false;
  bool get isSearching => _isSearching;
  bool get waitUser => _waitUser;
  set isSearching(value) {
    _isSearching = value;
    notifyListeners();
  }

  set waitUser(value) {
    _waitUser = value;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  void searchSwitch(bool isSearching) {
    _isSearching = isSearching;
    notifyListeners();
  }
}
