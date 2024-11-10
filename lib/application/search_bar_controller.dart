import 'package:flutter/cupertino.dart';

class SearchBarController with ChangeNotifier{
  bool isVisible = false;

  TextEditingController searchContoller = TextEditingController();

  void changeVisiblity(){
    isVisible == true?
    isVisible = false:
    isVisible = true;
    notifyListeners();
  }
}