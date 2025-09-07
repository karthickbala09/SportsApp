import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AthleteScreen extends StatefulWidget {
  const AthleteScreen({super.key});

  @override
  State<AthleteScreen> createState() => _AthleteScreenState();
}

class _AthleteScreenState extends State<AthleteScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Use asset video instead of network
    _controller = VideoPlayerController.asset(
      'assets/videos/athlete_video.mp4', // <-- Your asset video path
    )
      ..initialize().then((_) {
        setState(() {}); // Refresh to show video
      });

    // Optional: loop video
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildButton(IconData icon, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildCheck(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  Widget Topbar(String title, String bottom, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(color: Color(0xFF39D2C0)),
      child: Row(
        children: [
          Icon(icon, size: 50.sp, color: Colors.white),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$title',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5.h),
                Text('$bottom',
                    style:
                    TextStyle(color: Colors.white70, fontSize: 14.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Topbar("ATHLETE", "Sprint . Jump . Endurance", Icons.directions_run),

            // About Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  Text(
                    'Athletics involves speed, stamina, and technique. Improve your jumps and runs with guided tests.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            // Buttons
            buildButton(Icons.play_arrow, 'Start Assessment', Colors.greenAccent, () {}),
            buildButton(Icons.bar_chart, 'View Progress', Colors.blue, () {}),
            buildButton(Icons.book, 'Guidelines', Colors.grey, () {}),

            // Video Section
            Container(
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 200.h,
              child: Stack(
                children: [
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : CircularProgressIndicator(strokeWidth: 3.w),
                  ),
                  // Play/Pause button
                  Positioned.fill(
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 60.sp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ),
                  ),
                  // Optional: current time display
                  Positioned(
                    bottom: 10.h,
                    right: 10.w,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      color: Colors.black54,
                      child: Text(
                        '${_controller.value.position.inMinutes}:${(_controller.value.position.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cheat Detection Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cheat Detection',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  buildCheck('Hold your phone steady'),
                  SizedBox(height: 5.h),
                  buildCheck('Perform full reps'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
