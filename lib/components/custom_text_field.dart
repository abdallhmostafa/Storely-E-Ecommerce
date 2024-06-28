import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   const CustomTextField(
      {super.key,
      required this.labelText,
      this.hintText,
      this.formKey,
      required this.textInputAction,
      this.obscureText = false,
      required this.icon,
      this.validat,
      this.textEditingController,
      this.textInputType = TextInputType.text});
  final String labelText;
  final TextInputType textInputType;
  final String? hintText;
  final TextInputAction textInputAction;
  final bool obscureText;
  final IconData icon;
  final TextEditingController? textEditingController;
 final String? Function(String?)? validat;
  final GlobalKey? formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        validator: validat,
        controller: textEditingController,
        autocorrect: true,
        maxLength: 50,
        maxLines: 1,
        enableSuggestions: true,
        enableIMEPersonalizedLearning: true,
        enableInteractiveSelection: true,
        textInputAction: textInputAction,
        keyboardAppearance: Brightness.dark,
        keyboardType: textInputType,
        obscureText: obscureText,
        
        decoration: InputDecoration(
            suffixIcon: Icon(icon, size: 28.0),
            suffixIconColor: Colors.black,

          
            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
            alignLabelWithHint: true,
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
                borderSide: const BorderSide(color: Colors.grey, width: 1)),
            focusedBorder: OutlineInputBorder(
            
                borderRadius: BorderRadius.circular(
                  7.0,
          
                ),
                borderSide: const BorderSide(color: Colors.grey, width: 3)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
                borderSide: const BorderSide(color: Colors.grey, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
                borderSide: const BorderSide(color: Colors.red, width: 3))),
      ),
    );
  }
}
