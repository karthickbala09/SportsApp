import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  // 🔹 Simple placeholder data (can be replaced with backend API)
  final List<Map<String, dynamic>> leaderboardData = [
    {"name": "Arun", "score": 85},
    {"name": "Thangaraj", "score": 72},
    {"name": "Kumar", "score": 68},
    {"name": "Priya", "score": 64},
    {"name": "Rahul", "score": 58},
    {"name": "Meena", "score": 55},
  ];

  // 🔹 Current logged-in user (can come from auth backend)
  final String currentUser = "Thangaraj";

  @override
  Widget build(BuildContext context) {
    // Sort by score descending
    leaderboardData.sort((a, b) => b['score'].compareTo(a['score']));

    // Current user data
    final currentUserData = leaderboardData
        .firstWhere((u) => u['name'] == currentUser, orElse: () => {"score": 0, "name": currentUser});

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Leaderboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔹 Current User Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 15.r,
                  offset: Offset(0, 5.h),
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Your Score",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "${currentUserData['score']} pts",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  currentUserData['name'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // 🔹 Leaderboard List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                final user = leaderboardData[index];
                final isCurrentUser = user['name'] == currentUser;

                // Top 3 colors
                final gradientColor = index == 0
                    ? [Colors.amber.shade400, Colors.orange.shade600]
                    : index == 1
                    ? [Colors.grey.shade300, Colors.blueGrey.shade200]
                    : index == 2
                    ? [Colors.brown.shade300, Colors.orange.shade200]
                    : null;

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    gradient: gradientColor != null
                        ? LinearGradient(colors: gradientColor)
                        : null,
                    color: gradientColor == null
                        ? (isCurrentUser ? Colors.deepPurple.shade50 : Colors.white)
                        : null,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.r,
                        offset: Offset(0, 3.h),
                      )
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: isCurrentUser
                              ? Colors.deepPurple
                              : Colors.grey.shade300,
                        ),
                        Text(
                          "#${index + 1}",
                          style: TextStyle(
                            color: isCurrentUser ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        if (index == 0)
                          Icon(Icons.emoji_events, color: Colors.amber, size: 22.sp)
                        else if (index == 1)
                          Icon(Icons.emoji_events, color: Colors.grey, size: 22.sp)
                        else if (index == 2)
                            Icon(Icons.emoji_events, color: Colors.brown, size: 22.sp),
                        SizedBox(width: 8.w),
                        Text(
                          user['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: isCurrentUser ? Colors.deepPurple : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "${user['score']} pts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: isCurrentUser ? Colors.deepPurple : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
