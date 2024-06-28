
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/select_image_from.dart';
import 'package:storely/components/custom_password_field.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/provider/authentication.dart';
import 'package:storely/provider/user_data_provider.dart';

import '../components/custom_buttom.dart';
import '../components/custom_dialog.dart';
import '../components/custom_text_field.dart';
import '../constant.dart';

class Register extends StatelessWidget {
  Register({super.key});






  static const String id = 'register';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Register',
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
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 65.0,
                    minRadius: 65.0,
                    backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                    backgroundImage: (userProvider.imgPath != null
                            ? FileImage(userProvider.imgPath!)
                            : const AssetImage('assets/images/profile_1.svg'))
                        as ImageProvider,
                  ),
                  Positioned(
                      bottom: 0.0,
                      right: -10.0,
                      child: IconButton(
                          onPressed: () async {
                         await showImageOptions(context);
                         await  userProvider.uploadImage2FireStorage();

                         CustomErrorMessage.errorMessage(context);
                          },
                          icon: const Icon(
                            Icons.add_a_photo_rounded,
                            size: 25.0,
                            color: Colors.black87,
                          ))),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              CustomTextField(
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Empty Field';
                    } else if (value.length <= 3) {
                      return 'At Least 4 Characters';
                    } else {
                      authProvider.emailDone = true;
                      return null;
                    }
                  },
                  labelText: "User name",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textEditingController: nameController,
                  icon: Icons.person),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Empty Field';
                    } else if (value.length <= 3) {
                      return 'At Least 4 Characters';
                    } else {
                      authProvider.emailDone = true;
                      return null;
                    }
                  },
                  labelText: "Title",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textEditingController: titleController,
                  icon: Icons.title_rounded),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Empty Field';
                    } else if (value.length < 2 || value.length > 2) {
                      return 'Two Numbers Only';
                    } else if (value.contains(RegExp(r"^[0-9]{2}"))) {
                      return null;
                    } else {
                      authProvider.emailDone = true;
                      return 'Numbers Only';
                    }
                  },
                  labelText: "Age",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textEditingController: ageController,
                  icon: Icons.confirmation_num_rounded),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Empty Field';
                    } else if (!value.contains(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                      return 'Enter Valid Email';
                    } else {
                      authProvider.emailDone = true;
                      return null;
                    }
                  },
                  labelText: "Email",
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textEditingController: emailController,
                  icon: Icons.email),
              const SizedBox(
                height: 20.0,
              ),
              CustomPasswordField(
                onChange: (password) {
                  authProvider.onPasswordChange(password);
                },
                validat: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Field';
                  } else if (value.length < 8) {
                    return '';
                  } else {
                    return null;
                  }
                },
                labelText: "Password",
                textInputAction: TextInputAction.done,
                obscureText: authProvider.isVisiable ? false : true,
                textEditingController: passwordController,
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
                height: 20.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                            color: authProvider.is8Char
                                ? Colors.green
                                : Colors.white),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const CustomText(
                        text: "At Least 8 Characters",
                        color: Colors.black54,
                        fontSize: 14.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                            color: authProvider.hasNumber
                                ? Colors.green
                                : Colors.white),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const CustomText(
                        text: "At Least One Number",
                        color: Colors.black54,
                        fontSize: 14.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                            color: authProvider.hasCapitalLetter
                                ? Colors.green
                                : Colors.white),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const CustomText(
                        text: "Has Capital Letter",
                        color: Colors.black54,
                        fontSize: 14.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                            color: authProvider.hasSmallLetter
                                ? Colors.green
                                : Colors.white),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const CustomText(
                        text: "Has Small Letter",
                        color: Colors.black54,
                        fontSize: 14.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            shape: BoxShape.circle,
                            color: authProvider.hasSpecialChar
                                ? Colors.green
                                : Colors.white),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const CustomText(
                        text: "Has Special Character",
                        color: Colors.black54,
                        fontSize: 14.0,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomButtom(
                  widget: authProvider.isLoading
                      ? const SizedBox(
                          height: 34,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const CustomText(text: "Register"),
                  onpressed: () async {
                    authProvider.stateOfPassEmail();
                    if (authProvider.allDone) {
                      authProvider.changeLoading();
                      await authProvider.registerFunc(
                        emailAddress: emailController.text,
                        password: passwordController.text,
                        authProvider: authProvider,
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                        ageController: ageController,
                        nameController: nameController,
                        titleController: titleController,
                      );
                      CustomErrorMessage.messageError = authProvider.message;
                      CustomErrorMessage.errorMessage(context);

                      authProvider.changeLoading();
                    } else {
                      CustomErrorMessage.isError = true;
                      CustomErrorMessage.errorMessage(context);
                    }
                  }),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 17.0, color: Colors.black87),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
