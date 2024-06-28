import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_dialog.dart';
import 'package:storely/components/custom_password_field.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/provider/authentication.dart';
import 'package:storely/screens/reset_pass_screen.dart';
import 'package:storely/screens/register.dart';

import '../components/custom_buttom.dart';
import '../components/custom_text_field.dart';
import '../constant.dart';

class Login extends StatelessWidget {
  Login({super.key});

  static const String id = 'login';

  final passController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context);
    // final googleProvider = Provider.of<GoogleSignInProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Login  ',
          style: TextStyle(fontSize: 22.0, color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomTextField(
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
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  icon: Icons.email),
              const SizedBox(
                height: 20.0,
              ),
              CustomPasswordField(
                validat: (value) {
                  if (value!.isEmpty) {
                    authProvider.passDone = false;
                    return 'Empty Field';
                  } else if (value.length < 8) {
                    authProvider.passDone = false;

                    return 'At Least 8 Characters';
                  } else {
                    authProvider.passDone = true;
                    return null;
                  }
                },
                textEditingController: passController,
                labelText: "Password",
                textInputAction: TextInputAction.done,
                obscureText: authProvider.isVisiable ? false : true,
                icon: IconButton(
                  onPressed: () {
                    authProvider.visiability();
                  },
                  icon: Icon(
                    authProvider.isVisiable ? Icons.lock_open : Icons.lock,
                    color: Colors.black,
                    size: 28.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomButtom(
                  onpressed: () async {
                    if (authProvider.emailDone && authProvider.passDone) {
                      authProvider.changeLoading();
                      await authProvider.loginFunc(
                          emailAddress: emailController.text,
                          password: passController.text,
                          authProvider: authProvider,
                          context: context,
                          emailController: emailController,
                          passwordController: passController);
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
                          text: 'Login',
                        )),
              const SizedBox(
                height: 25.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ResetPasswordScreen.id);
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                ),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(fontSize: 17.0, color: Colors.black87),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Register.id);
                    },
                    style: TextButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 17.0, color: Colors.black87),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 10.0,
                      thickness: 1.2,
                    ),
                  ),
                  CustomText(
                    text: "OR",
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  Expanded(
                    child: Divider(
                      indent: 10.0,
                      thickness: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.0, color: kPrimaryBtColor)),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons8-google.svg',
                  ),
                  onPressed: () {
                    // googleProvider.googleLogin();
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
