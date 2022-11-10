import 'package:flutter/material.dart';

class ExampleProvider extends ChangeNotifier{

  int counter = 0;

  void addCounter(){
    counter ++;
    notifyListeners();
  }

}