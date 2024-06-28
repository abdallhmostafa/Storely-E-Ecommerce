import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_dialog.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/provider/authentication.dart';

import '../components/custom_buttom.dart';
import '../components/custom_text_field.dart';
import '../constant.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  static const String id = 'forget';
  final GlobalKey forKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(
              fontSize: 22.0,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
      ),
  
  
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Consumer<Authentication>(
          builder: (context, authProvider, child) =>
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Enter your Email To Reset Password:",
              style: TextStyle(
                  fontSize: 18.0, color: Colors.black87, letterSpacing: 2),
            ),
            const SizedBox(
              height: 25.0,
            ),
            CustomTextField(
              formKey: forKey,
              validat: (value) {
                if (value!.isEmpty) {
                  authProvider.emailDone = false;

                  return 'Empty Field';
                } else if (!value.contains(RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                  authProvider.emailDone = false;

                  return 'Enter Valid Email';
                } else {
                  authProvider.emailDone = true;
                  return null;
                }
              },
              labelText: "Email",
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              textEditingController: emailController,
              icon: Icons.email,
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomButtom(
                onpressed: () async {
                  if (authProvider.emailDone) {
                    authProvider.changeLoading();
                    await authProvider.resetPassword(
                        emailController.text, authProvider, context);

                    CustomErrorMessage.messageError = authProvider.message;
                    CustomErrorMessage.errorMessage(context);

                    authProvider.changeLoading();
                  }
                },
                widget: authProvider.isLoading
                    ? const SizedBox(
                        height: 34,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const CustomText(
                        text: 'Reset Password',
                      )),
          ]),
       
       
        ),
      ),
    );
  }
}
