import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storely/provider/user_data_provider.dart';
import 'package:storely/screens/home.dart';

import '../components/custom_dialog.dart';
import '../screens/login.dart';

class Authentication extends ChangeNotifier {
  bool _isLoading = false;

  bool isVisiable = false;
  bool passDone = false;
  bool emailDone = false;
  bool is8Char = false;
  bool allDone = false;
  bool hasNumber = false;
  bool hasCapitalLetter = false;
  bool hasSmallLetter = false;
  bool hasSpecialChar = false;
  bool get isLoading => _isLoading;
  UserProvider userDatabase = UserProvider();


  String errorMessage = 'Registered Successfully!';

  void changeLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void visiability() {
    isVisiable = !isVisiable;
    notifyListeners();
  }

  String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Empty Field!';
    } else {
      return null;
    }
  }

  void onPasswordChange(String password) {
    if (password.contains(RegExp(r'.{8,}'))) {
      is8Char = true;
    } else {
      is8Char = false;
    }
    if (password.contains(RegExp(r'[0-9]'))) {
      hasNumber = true;
    } else {
      hasNumber = false;
    }

    if (password.contains(RegExp(r'[a-z]'))) {
      hasSmallLetter = true;
    } else {
      hasSmallLetter = false;
    }
    if (password.contains(RegExp(r'[A-Z]'))) {
      hasCapitalLetter = true;
    } else {
      hasCapitalLetter = false;
    }
    if (password.contains(RegExp(r'[!@#$%^&*(){}<>,.?:;|\\/"]'))) {
      hasSpecialChar = true;
    } else {
      hasSpecialChar = false;
    }
    notifyListeners();
  }

  void stateOfPassEmail() {
    if (emailDone &&
        is8Char &&
        hasSpecialChar &&
        hasCapitalLetter &&
        hasNumber &&
        hasSmallLetter) {
      allDone = true;
    } else {
      allDone = false;
    }
    notifyListeners();
  }

  void falseState() {
    emailDone = false;
    is8Char = false;
    hasSpecialChar = false;
    hasCapitalLetter = false;
    hasNumber = false;
    hasSmallLetter = false;
    notifyListeners();
  }


  late final UserCredential userCredential;

  Future<void> loginFunc(
      {
    required String emailAddress,
     required String password,
    required  Authentication authProvider,
     required dynamic context,
     required TextEditingController emailController,
    required  TextEditingController passwordController}
      ) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
       userCredential = credential;
      CustomErrorMessage.isError = false;
      authProvider.setErrorMessage('Login Successfully!');
      Navigator.pushNamed(context, Home.id);
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomErrorMessage.isError = true;
        authProvider.setErrorMessage('User Not Found');
      } else if (e.code == 'wrong-password') {
        CustomErrorMessage.isError = true;
        authProvider.setErrorMessage('Wrong Password');
      } else {
        authProvider.setErrorMessage('There are an Error');
      }
    }
  }

  Future<void> registerFunc(
     {required String emailAddress,
     required String password,
     required Authentication authProvider,
    required  dynamic context,
    required  TextEditingController emailController,
    required  TextEditingController passwordController,
       required  TextEditingController nameController,
       required  TextEditingController titleController,
       required  TextEditingController ageController,

     }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
     await  userDatabase.addUser(name: nameController.text, title: titleController.text, age: ageController.text, imageUrl: userDatabase.url ?? 'assets/images/profile_1.svg' ,email: emailController.text,password:passwordController.text,credential: credential);
       // userDatabase.uploadImage2FireStorage();
      CustomErrorMessage.isError = false;
      authProvider.setErrorMessage('Register Successfully!');
      Navigator.pushReplacementNamed(context, Login.id);
      emailController.clear();
      passwordController.clear();
      authProvider.falseState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomErrorMessage.isError = true;
        authProvider.setErrorMessage('The Password is Too Weak!');
      } else if (e.code == 'email-already-in-use') {
        CustomErrorMessage.isError = true;

        authProvider.setErrorMessage('The Account Already Exists!');
      }
    } catch (e) {
      CustomErrorMessage.isError = true;

      authProvider.setErrorMessage('There are an Error');
    }
  }

  String get message => errorMessage;
  setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> resetPassword(
    String email,
    Authentication authProvider,
    dynamic context,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomErrorMessage.isError = false;

      authProvider.setErrorMessage('Password Send Successfully');
      Navigator.pushReplacementNamed(context, Login.id);
    } catch (e) {
      CustomErrorMessage.isError = true;

      authProvider.setErrorMessage('User Not Found');
    }
  }

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  void checkVerifiedEmail(Authentication authProvider) {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail(authProvider);
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        await FirebaseAuth.instance.currentUser!.reload();
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

        if (isEmailVerified) {
          timer.cancel();
        }
      });
      notifyListeners();
    }
  }

  void sendVerificationEmail(Authentication authProvider) async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      canResendEmail = false;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 5));
      canResendEmail = true;
      notifyListeners();
    } catch (e) {
      CustomErrorMessage.isError = true;

      authProvider.setErrorMessage(e.toString());
    }
  }
}
