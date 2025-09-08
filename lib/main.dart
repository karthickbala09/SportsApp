import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sihapp/Navigation/Navscreen.dart';
import 'package:sihapp/authentication/screens/Initial.dart';
import 'appscreens/Editprofile/viewprofile.dart';
import 'appscreens/Home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // set this to your UI design reference
      minTextAdapt: true,
      splitScreenMode: true, // enables split screen adaptation
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SIH App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: LoginScreens(), // your home page
        );
      },
    );
  }
}
