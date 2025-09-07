import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sihapp/authentication/screens/register.dart';

import 'login.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    return Scaffold(
      backgroundColor: Colors.white, // similar to secondaryBackground
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Image at the top
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/4894.jpg',
                width: double.infinity.w,
                height: 400.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40.h),

            // Login Button
            SizedBox(
              width: 250.w,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginStep1Screen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF39D2C0),// similar to secondary color
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'LogIn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Register Button
            SizedBox(
              width: 250.w,
              height: 60.h,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterPage()));
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F5), // same as secondaryBackground
                  elevation: 10,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
