import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/assets.dart';
import '../general/colors.dart';
import 'general_widget.dart';

class TextFieldaNormalWidget extends StatelessWidget {

  String text;
  String icon;
  int? maxLines;
  TextEditingController controller;

  TextFieldaNormalWidget({
    required this.text,
    required this.icon,
    this.maxLines,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(" $text"),
          ],
        ),
        divider6,
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: Offset(4, 4),
                blurRadius: 12.0)
          ]),
          child: TextFormField(
            validator: (value) {
              if(value != null && value.isEmpty){
                return "Campo Obligatorio";
              }
              return null;
            },
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                hintText: "Ingrese ${text.toLowerCase()}",
                hintStyle: TextStyle(
                  color: KBrandSecundaryColor.withOpacity(0.45),
                ),
                fillColor: Colors.white,
                filled: true,

                prefixIcon: SvgPicture.asset(
                  icon,
                  color: KBrandSecundaryColor.withOpacity(0.45),
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),
                focusedBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(14.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  borderSide: BorderSide.none,
                ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide.none,
              ),
              errorStyle: TextStyle(
                fontSize: 12.0,


              )

            ),
          ),
        )
      ],
    );
  }


}