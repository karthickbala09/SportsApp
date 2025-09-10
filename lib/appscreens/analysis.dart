import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Home_modeldata.dart';


// Model for performance
class Performance {
  final String level;
  final int percentage;

  Performance({required this.level, required this.percentage});
}

// Model to hold performance data per sport
class SportPerformance {
  final String sportName;
  final List<Performance> performances;

  SportPerformance({required this.sportName, required this.performances});
}

// Main Performance Page



 class PerformancePage extends StatelessWidget {
  PerformancePage({super.key});

  // Sample data, later you can fetch this from Firebase
  final List<SportPerformance> sportData = sportsList.map((sport) {
    return SportPerformance(
      sportName: sport.name,
      performances: [
        Performance(level: "Easy", percentage: 70),
        Performance(level: "Medium", percentage: 50),
        Performance(level: "Pro", percentage: 30),
      ],
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Overview"),
        backgroundColor: Color(0xFF39D2C0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: sportData.map((sport) => buildSportSection(context, sport)).toList(),
          ),
        ),
      ),
    );
  }

  // Builds section for each sport
  Widget buildSportSection(BuildContext context, SportPerformance sport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sport.sportName,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 180.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: sport.performances.map((perf) => buildPerformanceCard(perf)).toList(),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Builds the performance card for each level
  Widget buildPerformanceCard(Performance perf) {
    return UnconstrainedBox(
      child: Container(
        width: 140.w,
        height: 150.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
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
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                perf.level,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80.w,
                    height: 80.w,
                    child: CircularProgressIndicator(
                      value: perf.percentage / 100,
                      backgroundColor: Colors.white30,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 8.w,
                    ),
                  ),
                  Text(
                    "${perf.percentage}%",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
