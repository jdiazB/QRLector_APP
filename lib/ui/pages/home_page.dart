import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled5_clase9/db/db_admin.dart';
import 'package:untitled5_clase9/providers/db_provider.dart';
import 'package:untitled5_clase9/ui/general/colors.dart';
import 'package:untitled5_clase9/ui/pages/scanner_page.dart';
import 'package:untitled5_clase9/ui/widgets/button_filter_widget.dart';
import 'package:untitled5_clase9/ui/widgets/general_widget.dart';
import 'package:untitled5_clase9/utils/assets.dart';

import '../../models/qr_model.dart';
import '../../providers/example_provider.dart';
import '../widgets/itme_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String buttonVlue = "Hoy";
  List<QRModel> qrList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DBProvider dbProvider = Provider.of<DBProvider>(context, listen: false);
      dbProvider.getDataProvider();
    });
  }

  Future<void> getData() async {
    qrList = await DBAdmin.db.getQRData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ExampleProvider _exampleProvider = Provider.of<ExampleProvider>(context);
    DBProvider dbProvider = Provider.of<DBProvider>(context, listen: true);
    print("BUILD HOME!!!!!");

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScannerPage(),
                ));
          },
          backgroundColor: KBrandPrimaryColor,
          child: SvgPicture.asset(
            Assets.iconqr,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff1E1E1E),
        body: Column(
          children: [
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 4.5,
                            decoration: BoxDecoration(
                                color: Colors.black54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          divider40,
                          Text(
                            "Historial de Escaneos",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff1E1E1E),
                                fontWeight: FontWeight.w600),
                          ),
                          divider6,
                          Text(
                            "En esta seccion podras visualizar el historial de elementos registrados, tambien puedes agregar nuevos ingresos que prefieras",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 1.5,
                                color: Color(0xff1E1E1E).withOpacity(0.7),
                                fontWeight: FontWeight.w500),
                          ),
                          divider30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonFilterWidget(
                                  text: "Hoy",
                                  isSelected: buttonVlue == "Hoy",
                                  onTap: () {
                                    buttonVlue = "Hoy";
                                    setState(() {});
                                  }),
                              dividerWidth14,
                              ButtonFilterWidget(
                                  text: "Todos",
                                  isSelected: buttonVlue == "Todos",
                                  onTap: () {
                                    buttonVlue = "Todos";
                                    setState(() {});
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                    // segunda forma
                    // Expanded(child: ListView.builder(
                    //     itemCount: qrList.length,
                    //     physics: BouncingScrollPhysics(),
                    //     itemBuilder: (BuildContext context, int index){
                    //   return ItemListWidget(model: qrList[index]);
                    // }))

                    /*Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child:
                        Column(
                          children:
                            qrList.map((QRModel e) => ItemListWidget(model: e,)).toList(),

                        ),
                      ),
                    ),*/
                    Consumer<DBProvider>(builder: (context, provider, _){
                      return !provider.isLoading ?
                        Expanded(child: ListView.builder(
                          itemCount: provider.qrList.length,
                          itemBuilder: (BuildContext context, int index){
                        return ItemListWidget(model: provider.qrList[index]);
                      })) : Center(child: CircularProgressIndicator(),);
                    }),

                    // FutureBuilder(
                    //     future: DBAdmin.db.getQRData(),
                    //     builder: ((BuildContext context, AsyncSnapshot snap) {
                    //       if (snap.hasData) {
                    //         List<QRModel> list = snap.data;
                    //         return Expanded(
                    //             child: ListView.builder(
                    //                 itemCount: list.length,
                    //                 physics: BouncingScrollPhysics(),
                    //                 itemBuilder:
                    //                     (BuildContext context, int index) {
                    //                   return ItemListWidget(model: list[index]);
                    //                 }));
                    //       }
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
