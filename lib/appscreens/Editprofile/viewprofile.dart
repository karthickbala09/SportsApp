import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editprofilescreen.dart';
import 'modelclass.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ProfileModel profile = ProfileModel.empty(); // directly initialize

  final Color primaryColor = const Color(0xFF1E8F5E);
  final Color secondaryColor = const Color(0xFF39D2C0);

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('profile_json');
    if (s != null && s.isNotEmpty) {
      try {
        final data = jsonDecode(s);
        setState(() => profile = ProfileModel.fromJson(data));
      } catch (e) {
        // Keep empty profile if JSON is invalid
        profile = ProfileModel.empty();
      }
    }
    // else profile stays empty
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[600]),
          SizedBox(width: 10.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label\n',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14.sp),
                children: [
                  TextSpan(
                      text: value ?? '',
                      style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12.sp, color: primaryColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bannerHeight = 160.h;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Top Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  SizedBox(width: 12.w),
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: bannerHeight,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: profile.bannerImagePath != null &&
                                profile.bannerImagePath!.isNotEmpty
                                ? DecorationImage(
                              image: FileImage(File(profile.bannerImagePath!)),
                              fit: BoxFit.cover,
                            )
                                : null,
                            gradient: profile.bannerImagePath == null ||
                                profile.bannerImagePath!.isEmpty
                                ? LinearGradient(
                              colors: [primaryColor, secondaryColor],
                            )
                                : null,
                          ),
                        ),
                        Positioned(
                          left: 16.w,
                          bottom: -50.h,
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: profile.profileImagePath != null &&
                                profile.profileImagePath!.isNotEmpty
                                ? FileImage(File(profile.profileImagePath!))
                                : null,
                            child: profile.profileImagePath == null ||
                                profile.profileImagePath!.isEmpty
                                ? Icon(Icons.person,
                                size: 50.sp, color: Colors.grey)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.h),

                    // Name, About, Headline, Tags
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name.isNotEmpty ? profile.name : 'User Name',
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'About',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            profile.about.isNotEmpty ? profile.about : 'No bio provided.',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            profile.headline.isNotEmpty ? profile.headline : 'No headline',
                            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                          ),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 6.h,
                            children: [
                              _buildTag(profile.interestedSports?.isNotEmpty == true
                                  ? profile.interestedSports!
                                  : 'Sports'),
                              _buildTag(profile.education?.isNotEmpty == true
                                  ? profile.education!
                                  : 'Education'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ... continue with Details Card, Certificates, Edit button as before

                    // Details Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: secondaryColor),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Details',
                                  style: TextStyle(
                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8.h),
                              _infoRow(Icons.calendar_month, 'Age', profile!.age),
                              _infoRow(Icons.male, 'Gender', profile!.gender),
                              _infoRow(Icons.location_city, 'Location',
                                  '${profile!.city}, ${profile!.state}'),
                              _infoRow(Icons.phone, 'Contact', profile!.contact),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Certificates
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Certificates',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 100.h,
                            child: profile!.certificates.isEmpty
                                ? Center(child: Text('No certificates uploaded.'))
                                : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: profile!.certificates.length,
                              itemBuilder: (context, index) {
                                final p = profile!.certificates[index];
                                final name = p.split('/').last;
                                final isImage = name
                                    .toLowerCase()
                                    .endsWith('.png') ||
                                    name.toLowerCase().endsWith('.jpg') ||
                                    name.toLowerCase().endsWith('.jpeg');
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.r),
                                          color: Colors.grey[200],
                                          image: isImage
                                              ? DecorationImage(
                                              image: FileImage(File(p)),
                                              fit: BoxFit.cover)
                                              : null,
                                        ),
                                        child: !isImage
                                            ? Icon(Icons.picture_as_pdf,
                                            size: 32.sp)
                                            : null,
                                      ),
                                      SizedBox(height: 4.h),
                                      SizedBox(
                                        width: 80.w,
                                        child: Text(
                                          name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Edit Profile Button
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfileScreen()));
                            if(result == true){
                              await _loadProfile(); // reload after edit
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r)),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text('Edit Profile',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
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
