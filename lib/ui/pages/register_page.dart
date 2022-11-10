import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:untitled5_clase9/db/db_admin.dart';
import 'package:untitled5_clase9/models/qr_model.dart';
import 'package:untitled5_clase9/providers/example_provider.dart';
import 'package:untitled5_clase9/ui/general/colors.dart';
import 'package:untitled5_clase9/ui/widgets/button_normal_widget.dart';
import 'package:untitled5_clase9/ui/widgets/textfield_normal_widget.dart';
import 'package:untitled5_clase9/utils/assets.dart';

import '../../providers/db_provider.dart';
import '../widgets/general_widget.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  String valueQr;

  RegisterPage({
    required this.valueQr
});
  @override
  Widget build(BuildContext context) {
    ExampleProvider _exampleProvider = Provider.of<ExampleProvider>(context);
    DBProvider dbProvider = Provider.of<DBProvider>(context);
    print("BUILD REGISTER!!!!!!");


    return Scaffold(
      backgroundColor: KBrandSecundaryColor,
      body: Column(
        children: [
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
              flex: 7,
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32.0)),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _keyForm,
                        child: Column(children: [
                          divider20,
                          Container(
                            width: 48,
                            height: 4.5,
                            decoration: BoxDecoration(
                                color: Colors.black54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          divider20,
                          Text(
                            "Nuevo registro",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff1E1E1E),
                                fontWeight: FontWeight.w600),
                          ),
                          divider6,
                          Text(
                            "Por favor ingresa todos los datos solicitados a continuacion",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.0,
                                height: 1.5,
                                color: Color(0xff1E1E1E).withOpacity(0.7),
                                fontWeight: FontWeight.w500),
                          ),
                          divider30,
                          TextFieldaNormalWidget(
                            text: "Título",
                            icon: Assets.iconTitle,
                            controller: _titleController,
                          ),
                          divider20,
                          TextFieldaNormalWidget(
                            text: "Descripción",
                            icon: Assets.icondescription,
                            maxLines: 4,
                            controller: _descriptionController,
                          ),
                          divider20,
                          Text("Qr Generado"),
                          divider10,
                          QrImage(size: 120, data: valueQr),
                          divider14,
                          ButtonNormalWidget(
                            text: "Registrar",
                            onPressed: () async {
                              _exampleProvider.addCounter();
                              if(_keyForm.currentState!.validate()){
                                final DateTime now = DateTime.now();
                                final DateFormat formatterDate = DateFormat('dd-MM-yyyy');
                                final DateFormat formatterTime = DateFormat('Hm');
                                final String formattedDate = formatterDate.format(now);
                                final String formattedTime = formatterTime.format(now);


                                QRModel model = QRModel(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  date:  formattedDate,
                                  time: formattedTime,
                                  url: valueQr,
                                );

                                dbProvider.addRegister(model);


                                //int  res  = await DBAdmin.db.insertQR(model);
                                if( dbProvider.res> 0){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: KBrandSecundaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)
                                      ),
                                      content: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: Colors.white,),
                                          dividerWidth10,
                                          Text("Registro realizado con exito")
                                        ],
                                      )));
                                  Navigator.pop(context);
                                }
                              }



                            },
                          ),
                        ]),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
