import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mission_data.dart';
import 'missionclass.dart';


class MissionListScreen extends StatelessWidget {
  final String sportName;
  final String levelName;

  const MissionListScreen({
    super.key,
    required this.sportName,
    required this.levelName,
  });

  @override
  Widget build(BuildContext context) {
    // Get missions for selected sport and level
    List<Mission> missions = missionsData[sportName]?[levelName] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39D2C0),
        title: Text("$sportName - $levelName"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: missions.isEmpty
            ? Center(child: Text("No missions found"))
            : GridView.builder(
          itemCount: missions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final mission = missions[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    mission.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
