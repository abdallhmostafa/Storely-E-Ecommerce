
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storely/provider/user_data_provider.dart';

import 'custom_text.dart';


  Future showImageOptions(BuildContext context)async => showDialog  (
    context: context,

    builder: (context) => Consumer<UserProvider>(builder: (context, userProvider, child) =>
        SimpleDialog(
          titleTextStyle:const TextStyle(letterSpacing: 2.0),
          title:const CustomText(text: 'Choose Image From:',color: Colors.black,fontSize: 18.0),
          children: [
            SimpleDialogOption(
              onPressed: () async{
             await   userProvider.uploadImg2Screen(imageSource: ImageSource.camera);

                Navigator.pop(context);
              },
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Camera',color: Colors.black54,fontSize: 20.0,letterSpacing: 3.5,),
                  Icon(Icons.camera_alt_rounded,color: Colors.black54,size: 25.0,)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async{
                await    userProvider.uploadImg2Screen(imageSource: ImageSource.gallery);
                Navigator.pop(context);

              },
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Gallery',color: Colors.black54,fontSize: 20.0,letterSpacing: 3.0),
                  Icon(Icons.photo,color: Colors.black54,size: 25.0,)
                ],
              ),
            ),

          ],

        ),
    ),);



