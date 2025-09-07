import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihapp/appscreens/Sportsassesments.dart';

import 'Editprofile/editprofilescreen.dart';
import 'Editprofile/viewprofile.dart';
import 'Editprofile/modelclass.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Profile data variables
  String userName = "User Name";
  String userHeadline = "Your headline";
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfile(); // Load profile at start
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('profile_json');
    if (s != null) {
      final profile = ProfileModel.fromJson(jsonDecode(s));
      setState(() {
        userName = profile.name;
        userHeadline = profile.headline;
        profileImagePath = profile.profileImagePath;
      });
    }
  }

  // Open EditProfile and reload profile after save
  Future<void> _editProfile() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfileScreen()));
    if (result != null) {
      _loadProfile(); // Reload updated profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 5.0.w,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Flexible Drawer Header with top space
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 16.h), // Added top padding
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: profileImagePath != null
                        ? FileImage(File(profileImagePath!))
                        : AssetImage("assets/profile.png") as ImageProvider,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          userHeadline,
                          style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {},
              title: Text("Settings", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.settings, size: 30),
            ),
            ListTile(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProfileScreen()));
                _loadProfile(); // Refresh after coming back from profile view
              },
              title: Text("Profile", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.person, size: 30),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top AppBar with avatar, search, notification
              Material(
                elevation: 5.w,
                child: Container(
                  height: 60.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: CircleAvatar(
                          backgroundImage: profileImagePath != null
                              ? FileImage(File(profileImagePath!))
                              : AssetImage("assets/profile.png") as ImageProvider,
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 220.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(color: Color(0xFF39D2C0)),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notification_add_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Athlete Cards
              atheletcard(title: "Athletics", imagepath: "assets/R.jpeg", context: context),
              atheletcard(title: "Badminton", imagepath: "assets/badm.jpg", context: context),
              atheletcard(title: "Hockey", imagepath: "assets/hockey.jpg", context: context),
              atheletcard(title: "Kabaddi", imagepath: "assets/kabbadi.jpg", context: context),
              atheletcard(title: "Volleyball", imagepath: "assets/volly.jpg", context: context),
              atheletcard(title: "Table Tennis", imagepath: "assets/tt.jpg", context: context),
              atheletcard(title: "High Jump", imagepath: "assets/hj.jpg", context: context),

            ],
          ),
        ),
      ),
    );
  }
}

Widget atheletcard({required String title, required imagepath,  required BuildContext context,}) {
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AthleteScreen()));
      },
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Stack(
        children: [
          Material(
            elevation: 5.w,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 150.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image:
                  DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            left: 70,
            top: 140,
            child: Container(
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Color(0xFF39D2C0),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
