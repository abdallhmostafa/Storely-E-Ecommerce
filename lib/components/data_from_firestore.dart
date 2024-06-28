import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/components/custom_text_field.dart';
import 'package:storely/constant.dart';

class GetDataFromFireStore extends StatelessWidget {
  final String documentId;
  final nameController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection(kUser);
  final credential =FirebaseAuth.instance.currentUser;
  GetDataFromFireStore({required this.documentId, super.key});

  void showEditeDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Change The Name"),
          contentPadding:
              const EdgeInsets.only(right: 10.0, top: 15.0, left: 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusCircular)),
          content: CustomTextField(
            labelText: "Name",
            textEditingController: nameController,
            icon: Icons.person,
            textInputAction: TextInputAction.done,
            validat: (value) {
              if (value!.isEmpty) {

                return "Empty Value";

              } else if (value.length < 3) {
                return "At Least 3 Characters";
              } else {

                return null;
              }
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: kSecondBtColor),
                )),
            TextButton(
                onPressed: ()async {
                 await users.doc(credential!.uid).update({kName: nameController.text});
                 Navigator.pop(context);
                 },
                child: const Text(
                  "Change",
                  style: TextStyle(color: kPrimaryBtColor),
                )),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CustomText(
                        text: 'Name: ',
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                      CustomText(
                        text: "${data[kName]}",
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () => showEditeDialog(context),
                      icon: const Icon(
                        Icons.edit,
                        size: 20.0,
                      )),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const CustomText(
                    text: 'Title: ',
                    color: Colors.black87,
                    fontSize: 18.0,
                  ),
                  CustomText(
                    text: "${data[kTile]}",
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const CustomText(
                    text: 'Age: ',
                    color: Colors.black87,
                    fontSize: 18.0,
                  ),
                  CustomText(
                    text: "${data[kAge]}",
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ],
              ),
            ],
          );
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
