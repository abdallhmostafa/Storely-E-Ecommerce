import 'package:flutter/material.dart';
import 'package:storely/constant.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom(
      {required this.widget, super.key, this.backgroundColor = kPrimaryBtColor,this.onpressed});
   Widget widget;
  final Color backgroundColor;
  VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,

          minimumSize:const Size(150, 40) ,
          enableFeedback: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0))),
      child:widget,
    );
  }
}
