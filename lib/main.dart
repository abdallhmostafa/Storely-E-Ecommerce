import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storely/components/custom_text.dart';
import 'package:storely/constant.dart';
import 'package:storely/firebase_options.dart';
import 'package:storely/provider/authentication.dart';
import 'package:storely/provider/cart.dart';
import 'package:storely/provider/user_data_provider.dart';
import 'package:storely/screens/check_out.dart';
import 'package:storely/screens/details.dart';
import 'package:storely/screens/profile_screen.dart';
import 'package:storely/screens/reset_pass_screen.dart';
import 'package:storely/screens/home.dart';
import 'package:storely/screens/login.dart';
import 'package:storely/screens/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Storely());
}

class Storely extends StatelessWidget {
  const Storely({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//      statusBarColor: kAppBarColor,
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Authentication(),
        ),
          ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: kPrimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          Home.id: (context) => const Home(),
          Details.id: (context) => const Details(),
          CheckOut.id: (context) => const CheckOut(),
          UserProfile.id: (context) =>  UserProfile(),

          ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryBtColor,
                  strokeWidth: 3,
                ),
              );
            }
            else if (snapshot.hasError) {
              return const Center(
                child: CustomText(
                  text: "Bad Connection",
                  color: Colors.red,
                  fontSize: 25.0,
                ),
              );
            }
            else if (snapshot.hasData) {
              return const Home();
            } else {
              return Login();
            }
          },
        ),
    
      ),
    );
  }
}
