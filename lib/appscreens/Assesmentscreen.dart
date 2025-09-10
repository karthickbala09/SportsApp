import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mission_list.dart';

class AssessmentScreen extends StatelessWidget {
  final String sportName;

  const AssessmentScreen({super.key, required this.sportName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF39D2C0),
        toolbarHeight: 70.h,
        title: Text(
          "$sportName Assessment",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              levelCard(context, sportName, "Easy"),
              SizedBox(height: 50.h),
              levelCard(context, sportName, "Medium"),
              SizedBox(height: 50.h),
              levelCard(context, sportName, "Pro"),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget levelCard(BuildContext context, String sportName, String levelName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MissionListScreen(
              sportName: sportName,
              levelName: levelName,
            ),
          ),
        );
      },
      child: Container(
        height: 80.h,
        width: 350.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: SizedBox(
                height: 30.h,
                width: 30.w,
                child: Image.asset("assets/target.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Text(
                "$levelName - LEVEL",
                style: TextStyle(
                  color: Color(0xFF39D2C0),
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
