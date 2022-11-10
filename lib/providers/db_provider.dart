import 'package:flutter/material.dart';
import 'package:untitled5_clase9/db/db_admin.dart';
import 'package:untitled5_clase9/models/qr_model.dart';

class DBProvider extends ChangeNotifier{

  List<QRModel> qrList = [];
  bool isLoading = true;
  int res = 0;

  Future<void> getDataProvider() async {
    isLoading = true;
    notifyListeners();
    qrList = await DBAdmin.db.getQRData();
    // para que sea de forma descendente
    qrList = qrList.reversed.toList();

    isLoading = false;
    notifyListeners();
  }
  Future<void> addRegister(QRModel model) async {
     res = await DBAdmin.db.insertQR(model);
     notifyListeners();
     getDataProvider();
  }
}