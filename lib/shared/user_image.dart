import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/constant.dart';

class GetUserImage extends StatelessWidget {
 final CollectionReference users = FirebaseFirestore.instance.collection(kUser);
  final credential =FirebaseAuth.instance.currentUser;
  GetUserImage({ super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const CustomText(
            text: "Something went wrong!",
            fontSize: 16.0,
            color: Colors.red,
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const CustomText(
            text: "Document Doesn't Exist!",
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return  Image.network(data[kImageUrl]);
        }

        return const Column(
          children: [
            CircularProgressIndicator(
              color: kSecondBtColor,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text("Loading..."),
          ],
        );
      },
    );
  }
}
