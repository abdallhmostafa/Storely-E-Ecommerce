import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({ required this.text,required this.icon,required this.onTap,super.key});
final VoidCallback onTap;
final String text;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      enableFeedback: true,

      title:  Text(
        text,
        style:const TextStyle(fontSize: 20.0, color: Colors.black54),
      ),
      leading:  Icon(
        icon,
        size: 30,
      ),
      onTap: onTap,
    );
  }
}
