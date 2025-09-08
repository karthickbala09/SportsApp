import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Editprofile/modelclass.dart';
import 'Editprofile/viewprofile.dart';
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
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              onTap: () {}, // Settings placeholder
              title: Text("Settings", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.settings, size: 30),
            ),
            ListTile(
              onTap: _viewProfile,
              title: Text("Profile", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.person, size: 30),
            ),
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
                      icon: Icon(Icons.notification_add_sharp, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    atheletcard(title: "Athletics", imagepath: "assets/R.jpeg", context: context, videopath: 'helo.mp4', pagename: "Athelete"),
                  //  atheletcard(title: "Sprinting (100m)", imagepath: "assets/100m.jpg", context: context, videopath: "assets/100m.mp4", pagename: "Athletics"),
               //     atheletcard(title: "Sprinting (200m)", imagepath: "assets/200m.jpg", context: context, videopath: "assets/200m.mp4", pagename: "Athletics"),
              //      atheletcard(title: "Sprinting (400m)", imagepath: "assets/400m.jpg", context: context, videopath: "assets/400m.mp4", pagename: "Athletics"),
              //      atheletcard(title: "Middle/Long Distance (800m)", imagepath: "assets/800m.jpg", context: context, videopath: "assets/800m.mp4", pagename: "Athletics"),
              //      atheletcard(title: "Middle/Long Distance (1500m)", imagepath: "assets/1500m.jpg", context: context, videopath: "assets/1500m.mp4", pagename: "Athletics"),
               //     atheletcard(title: "Hurdles", imagepath: "assets/hurdles.jpg", context: context, videopath: "assets/hurdles.mp4", pagename: "Athletics"),
                //    atheletcard(title: "Long Jump", imagepath: "assets/longjump.jpg", context: context, videopath: "assets/longjump.mp4", pagename: "Athletics"),
                 //   atheletcard(title: "High Jump", imagepath: "assets/highjump.jpg", context: context, videopath: "assets/highjump.mp4", pagename: "Athletics"),
                 //   atheletcard(title: "Shot Put", imagepath: "assets/shotput.jpg", context: context, videopath: "assets/shotput.mp4", pagename: "Athletics"),
                 //   atheletcard(title: "Javelin Throw", imagepath: "assets/javelin.jpg", context: context, videopath: "assets/javelin.mp4", pagename: "Athletics"),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget atheletcard({required String title, required imagepath, required BuildContext context,required String videopath,required pagename}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AthleteScreen(sportsname:pagename ,sportsvideourl:videopath ,)));
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
                image: DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover),
              ),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
