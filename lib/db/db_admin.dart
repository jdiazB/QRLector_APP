import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/qr_model.dart';

class DBAdmin {

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();
  Database? myDatabase;
  //esto para saber que existe la base de datos
  Future<Database?> getDatabase() async {
    if(myDatabase != null){
      return myDatabase;
    }
    myDatabase = await initDatabase();
    return myDatabase;
  }
  Future<Database> initDatabase() async {

      Directory directory = await   getApplicationDocumentsDirectory();
      String path = join(directory.path, "QrDB.db");
      return openDatabase(path,version: 1,onCreate: (Database db,int version) async {
        await db.execute("CREATE TABLE QR(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, data TEXT, time TEXT, url TEXT)");
      },);

  }
  Future<int> insertQR(QRModel model) async {
    Database? db = await getDatabase();
    int res = await db!.insert("QR", {

      "title": model.title,
      "description": model.description,
      "data": model.date,
      "time": model.time,
      "url": model.url,


    }
    );
    return res;
  }
  Future<List<QRModel>> getQRData() async{
    //primero para obtener los valores
    Database? db = await getDatabase();
    List qrList = await db!.query("QR");
    // for(var item in qrList){
    //   print(item);
    // }
    //primera forma
    //List<QRModel> listModel = [];

    //qrList.forEach((element) {
    //  QRModel model = QRModel.fromJson(element);
    //  listModel.add(model);
    //});
    // segunda forma
    List<QRModel> listmodel = qrList.map((e) => QRModel.fromJson(e)).toList();




    return listmodel;
  }

}