import 'package:flutter/cupertino.dart';

class SutudentIdContoller with ChangeNotifier {
  bool isVisible = false;

  void changeVisiblity() {
    isVisible == true ? isVisible = false : isVisible = true;
    notifyListeners();
  }
}
