import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storely/components/custom_dialog.dart';
import 'package:storely/constant.dart';
import 'package:path/path.dart' show basename;
class UserProvider extends ChangeNotifier {

  File? imgPath;
  String? url;


  String? imgName;
  CollectionReference users = FirebaseFirestore.instance.collection(kUser);
 bool nameController =false;
  final userCredential = FirebaseAuth.instance.currentUser;



  Future<void> uploadImage2FireStorage()async{
    Reference referenceStorage = FirebaseStorage.instance.ref(imgName);
    await referenceStorage.putFile(imgPath!);
    url = await  referenceStorage.getDownloadURL();
    url =url;
    // print( "================ The Url oF Image: $url ===============");
  }



  uploadImg2Screen({required ImageSource imageSource})async{
    final XFile pickedImg = (await ImagePicker().pickImage(source: imageSource))!;

    try{
      if(pickedImg != null){
        imgPath = File(pickedImg!.path) ;
        // print("---------------- The Path Of Image Is :$imgPath -----------------");
        String uniqueImageName=DateTime.now().millisecondsSinceEpoch.toString();
        imgName = basename(pickedImg!.path);
        imgName = '$uniqueImageName$imgName';


        CustomErrorMessage.isError= false;
        CustomErrorMessage.messageError="Image Selected Successfully";
      }
      else{
        CustomErrorMessage.isError= true;
        CustomErrorMessage.messageError="No Image Selected!";
      }
    }catch(e){
      CustomErrorMessage.isError= true;
      CustomErrorMessage.messageError="There are an Error!";
    }
    notifyListeners();
  }







  Future<void> addUser ({
    required String name,
    required String title,
    required String age,
    required String email,
    required String password,
    required String imageUrl,
    required  UserCredential credential,
  })async {
    // Call the user's CollectionReference to add a new user
    return users.doc(credential.user!.uid)
        .set({
      kName: name,
      kTile: title,
      kAge: age,
      kPassword:password,
      kEmail: email,
      kImageUrl:imageUrl,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }










}
