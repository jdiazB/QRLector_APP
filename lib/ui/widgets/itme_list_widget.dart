import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled5_clase9/models/qr_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets.dart';
import 'general_widget.dart';

class ItemListWidget extends StatelessWidget {
  QRModel model;
  ItemListWidget({
    required this.model
});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ]),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),),
                divider3,
                Text(
                  model.description,
                  style: TextStyle(
                      height: 1.2
                  ),),
                divider6,
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.iconCalender,
                      height: 16.0,
                      color: Colors.black54,
                    ),
                    Text(model.date, style: TextStyle(
                        color: Colors.black54
                    ),),
                    dividerWidth6,
                    SvgPicture.asset(Assets.iconTime),
                    Text(model.time
                      ,style: TextStyle(
                          color: Colors.black54
                      ),),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            child: SvgPicture.asset(Assets.iconLink),
              onTap: () {
                 Uri url = Uri.parse(model.url);
                launchUrl(url);
              },
          )
        ],
      ),
    );
  }
}
