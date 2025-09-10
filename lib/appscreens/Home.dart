import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihapp/authentication/auth_services.dart';
import 'package:sihapp/authentication/screens/Initial.dart';
import '../Home_modeldata.dart';
import '../Homemodel_class.dart';

import 'Editprofile/modelclass.dart';
import 'Editprofile/viewprofile.dart';
import 'Settingscreen.dart';
import 'Sportsassesments.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = "User Name";
  String userHeadline = "Your headline";
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
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

  Future<void> _viewProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewProfileScreen()),
    );
    if (result == true) {
      await _loadProfile(); // Reload profile if edited
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
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 16.h),
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
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.black54),
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingsScreen()));
              }, // Settings placeholder
              title: Text("Settings", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.settings, size: 30),
            ),
            ListTile(
              onTap: _viewProfile,
              title: Text("Profile", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.person, size: 30),
            ),
            SizedBox(height: 300.h,),
            Padding(
              padding: EdgeInsets.only(left: 30.w,right: 30.w),
              child: SizedBox(
                height: 60.h,
                child: GestureDetector(
                  onTap: () async{
                    AuthService().signOut();
                    // Clear shared preferences if needed
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    // Navigate to login screen and remove all previous routes
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreens()),
                    (route) => false);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Color(0xFF39D2C0),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("LogOut",style: TextStyle(color: Colors.black,fontSize: 26.sp,fontWeight: FontWeight.bold),),
                        Icon(Icons.logout,size: 26.sp,)
                      ],
                    ),

                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
                      icon: Icon(Icons.notification_add_sharp,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sportsList.length,
                itemBuilder: (context, index) {
                  final sport = sportsList[index];
                  return athleteCard(sport: sport, context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget athleteCard({
  required Sport sport,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AthleteScreen(
            sportsname: sport.name,
            sportsvideourl: sport.videoUrl,
            sportssubtitle: sport.subtitle,
            sportsabout: sport.aboutText,

          ),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Fixed size image card
          Container(
            height: 160.h,
            width: double.infinity, // Makes the card stretch horizontally
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                sport.imagepath,
                fit: BoxFit.cover, // Adjust image to fill card without stretching
              ),
            ),
          ),

          // Title container overlapping the card with colors
          Positioned(
            left: 20.w,
            bottom: -20.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                sport.name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
