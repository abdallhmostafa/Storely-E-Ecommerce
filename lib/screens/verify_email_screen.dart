import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_buttom.dart';
import 'package:storely/components/custom_dialog.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/constant.dart';
import 'package:storely/provider/authentication.dart';
import 'package:storely/screens/home.dart';
import 'package:storely/screens/login.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(builder: (context, authProvider, child) {
      authProvider.checkVerifiedEmail(authProvider);
      return authProvider.isEmailVerified
          ? const Home()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'Verify Email',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500),
                ),
                iconTheme: const IconThemeData(color: kPrimaryColor),
                backgroundColor: kAppBarColor,
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "A Verification Email Has Been Sent To your Email",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    CustomButtom(
                        onpressed: () async {
                          authProvider.changeLoading();
                            authProvider.canResendEmail
                              ? authProvider.sendVerificationEmail(authProvider)
                              : null;
                                CustomErrorMessage.messageError =
                              authProvider.message;
                          CustomErrorMessage.errorMessage(context);
                          authProvider.changeLoading();
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
                                text: 'Resend Email',
                              )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomButtom(
                        widget: const CustomText(text: 'Cancel'),
                        backgroundColor: kSecondBtColor,
                        onpressed: () =>
                            Navigator.pushReplacementNamed(context, Login.id)),
                  ]),
            );
    });
  }
}
