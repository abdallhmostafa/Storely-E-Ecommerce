

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/select_image_from.dart';
import 'package:storely/components/custom_dialog.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/components/data_from_firestore.dart';
import 'package:storely/constant.dart';
import 'package:storely/provider/user_data_provider.dart';
import 'package:storely/shared/user_image.dart';

class UserProfile extends StatelessWidget {
   UserProfile({super.key});
  static const String id = 'userProfile';
    final userCredential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'User Profile',
          style: TextStyle(fontSize: 22.0, color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
        actions: [
          TextButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          }, child:const Row(
            children: [
               CustomText(text: "Logout",fontSize: 16.0,),
              SizedBox(width: 4.0,),
              Icon(Icons.logout,color: Colors.white,),

            ],
          ),)
        ],
      ),
      body: SingleChildScrollView(
        physics:const  BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Consumer<UserProvider>(builder: (context, userProvider, child) =>
                  Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 65.0,
                    minRadius: 65.0,
                    backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                    backgroundImage: (userProvider.imgPath != null
                        ?GetUserImage()
                        : const AssetImage('assets/images/profile_1.svg'))
                    as ImageProvider,
                  ),
                  Positioned(
                      bottom: 0.0,
                      right: -10.0,
                      child: IconButton(
                          onPressed: () async {
                            await   showImageOptions(context);
                             userProvider.uploadImage2FireStorage();
                            CustomErrorMessage.errorMessage(context);
                          },
                          icon: const Icon(
                            Icons.add_a_photo_rounded,
                            size: 25.0,
                            color: Colors.black87,
                          ))),
                ],
              ) ,),

              const SizedBox(height: 20.0,),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusCircular),
                  border: Border.all(color: Colors.grey.shade300,width: 3,style: BorderStyle.solid),

                ),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: kSecondBtColor,
                          borderRadius: BorderRadius.circular(kRadiusCircular),
                        ),
                        child:const CustomText(text: 'Firebase Date',)),
                   const SizedBox(height: 15.0,),
                     Column(
                      children: [
                        Row(
                          children: [
                            const   CustomText(text: 'Email: ',color: Colors.black87,fontSize: 18.0,),
                            CustomText(text: "${userCredential!.email}",color: Colors.black,fontSize: 18.0,),
                          ],
                        ),
                        const  SizedBox(height: 20.0,),
                        Row(
                          children: [
                            const  CustomText(text: 'Created Date: ',color: Colors.black87,fontSize: 18.0,),
                            CustomText(text: DateFormat.yMd().add_jm().format(userCredential!.metadata.creationTime!),color: Colors.black,fontSize: 18.0,),

                          ],
                        ),
                        const SizedBox(height: 20.0,),

                        Row(
                          children: [
                            const  CustomText(text: 'Last Signed Out: ',color: Colors.black87,fontSize: 18.0,),

                            CustomText(text: DateFormat.yMd().add_jm().format(userCredential!.metadata.lastSignInTime!),color: Colors.black,fontSize: 18.0,),

                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusCircular),
                  border: Border.all(color: Colors.grey.shade300,width: 3,style: BorderStyle.solid),

                ),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: kSecondBtColor,
                          borderRadius: BorderRadius.circular(kRadiusCircular),
                        ),
                        child:const CustomText(text: 'FireStore Date',)),
                    const SizedBox(height: 15.0,),
                    GetDataFromFireStore(documentId:userCredential!.uid,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
