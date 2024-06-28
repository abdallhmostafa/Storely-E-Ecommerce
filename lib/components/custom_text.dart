import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {required this.text,
      super.key,
      this.color = Colors.white,
      this.fontSize = 22.0,
        this.letterSpacing,
      this.fontWeight=FontWeight.w500});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  final double ?letterSpacing;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        softWrap: true,

        style: TextStyle(
  letterSpacing:letterSpacing ,
            color: color, fontSize: fontSize, fontWeight: fontWeight));
  }
}
