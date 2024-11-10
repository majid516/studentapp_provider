import 'package:flutter/material.dart';

class IconChangeProvider with ChangeNotifier{
  var isList = true;

  void changeIcon(){
    isList == true?
    isList = false:
    isList = true;
    notifyListeners();
  }
}