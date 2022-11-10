import 'package:flutter/material.dart';

import '../general/colors.dart';

class ButtonNormalWidget extends StatelessWidget {
  String text;
  Function? onPressed;
  ButtonNormalWidget({
    required this.text,
    required this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            onPressed: onPressed != null ? (){ onPressed!(); } : null,
            style: ElevatedButton.styleFrom(
            backgroundColor: KBrandPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0))
        ),child: Text(text))
    );
  }
}
