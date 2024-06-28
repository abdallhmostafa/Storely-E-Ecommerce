import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_list_tile.dart';
import 'package:storely/screens/profile_screen.dart';
import 'package:storely/shared/user_image.dart';

import '../constant.dart';
import '../models/product_model.dart';
import '../provider/cart.dart';
import '../shared/custom_app_bar.dart';
import 'check_out.dart';
import 'details.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        backgroundColor: kBackgroundColor,
        child: Column(
          children: [
             UserAccountsDrawerHeader(
                currentAccountPictureSize:const Size.square(80),
                currentAccountPicture:  CircleAvatar(
                  backgroundImage:
                      AssetImage(GetUserImage().toString()),
                ),
                decoration:const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo2.png')),
                ),
                accountName:  Text(
                  user.displayName?? "Unknown",
                  style:const  TextStyle(
                    fontSize: 14.0,
                    color: kPrimaryColor,
                  ),
                ),
                accountEmail: Text(
                  user.email!,
                  // 'abdallhelrabiey255@gmail.com',

                  style:const TextStyle(fontSize: 12.0, color: kPrimaryColor),
                )),

            CustomListTile(text: 'Home', icon: Icons.home, onTap: () {}),
            CustomListTile(text: 'My Products', icon: Icons.shopping_cart, onTap: () => Navigator.pushNamed(context, CheckOut.id)),
            const  AboutListTile(
              icon:  Icon(
                Icons.info,
                size: 30,
              ),
              applicationIcon: FlutterLogo(),
              // applicationLegalese: 'Legalese',
              applicationName: 'Storely',
            applicationVersion: 'Version 1.0.0',
            dense:false ,
            aboutBoxChildren: [
              Text("This App Created By elRabiey Company"),
            ],
            child:   Text(
              'About',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
            ),
            CustomListTile(text: 'User Profile', icon: Icons.person_2_rounded, onTap: ()=> Navigator.pushNamed(context,UserProfile.id ),),
            CustomListTile(text: 'Log Out',icon:Icons.output ,onTap:() async =>
              await FirebaseAuth.instance.signOut()
            , ),

          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: kAppBarColor,
        actions: const [ItemAndPrice()],
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: listOfData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
          mainAxisExtent: 280,

        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Details(productData: listOfData[index]),
                  ));
            },
            child: GridTile(
                child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(
                        kRadiusCircular,
                      ),
                      topLeft: Radius.circular(kRadiusCircular)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.asset(
                      listOfData[index].path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          kRadiusCircular,
                        ),
                        bottomLeft: Radius.circular(kRadiusCircular)),
                    color: kPrimaryBtColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${listOfData[index].price.ceil()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: kPrimaryColor,
                            fontSize: 20.0),
                      ),
                      Consumer<Cart>(
                        builder: (context, value, child) {
                          return IconButton(
                              onPressed: () {
                                value.addProduct(listOfData[index]);
                              },
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              icon: const Icon(
                                Icons.add,
                                size: 25.0,
                                color: kPrimaryColor,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
