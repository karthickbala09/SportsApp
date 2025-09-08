import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihapp/Database_services/students_database.dart';

import 'modelclass.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final headlineCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final educationCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final districtCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final sportsCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  String? _profileImagePath;
  String? _bannerImagePath;
  final List<String> _certificates = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString('profile_json');
    final profile = s != null
        ? ProfileModel.fromJson(jsonDecode(s))
        : ProfileModel.empty();
    setState(() {
      nameCtrl.text = profile.name;
      headlineCtrl.text = profile.headline;
      ageCtrl.text = profile.age ?? '';
      heightCtrl.text = profile.height ?? '';
      weightCtrl.text = profile.weight ?? '';
      genderCtrl.text = profile.gender ?? '';
      educationCtrl.text = profile.education ?? '';
      cityCtrl.text = profile.city ?? '';
      districtCtrl.text = profile.district ?? '';
      stateCtrl.text = profile.state ?? '';
      countryCtrl.text = profile.country ?? '';
      contactCtrl.text = profile.contact ?? '';
      sportsCtrl.text = profile.interestedSports ?? '';
      aboutCtrl.text = profile.about;
      _profileImagePath = profile.profileImagePath;
      _bannerImagePath = profile.bannerImagePath;
      _certificates.clear();
      _certificates.addAll(profile.certificates);
    });
  }

  Future<void> _pickProfilePhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) setState(() => _profileImagePath = picked.path);
  }

  Future<void> _pickBannerPhoto() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) setState(() => _bannerImagePath = picked.path);
  }

  Future<void> _pickCertificates() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      for (var p in result.paths.whereType<String>()) {
        if (!_certificates.contains(p)) _certificates.add(p);
      }
      setState(() {});
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final profile = ProfileModel(
      name: nameCtrl.text.trim(),
      headline: headlineCtrl.text.trim(),
      age: ageCtrl.text.trim(),
      height: heightCtrl.text.trim(),
      weight: weightCtrl.text.trim(),
      gender: genderCtrl.text.trim(),
      education: educationCtrl.text.trim(),
      city: cityCtrl.text.trim(),
      district: districtCtrl.text.trim(),
      state: stateCtrl.text.trim(),
      country: countryCtrl.text.trim(),
      contact: contactCtrl.text.trim(),
      interestedSports: sportsCtrl.text.trim(),
      about: aboutCtrl.text.trim(),
      profileImagePath: _profileImagePath,
      bannerImagePath: _bannerImagePath,
      certificates: List<String>.from(_certificates),
    );




    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_json', jsonEncode(profile.toJson()));
    
    // stroing in firestore .
    
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
     await DatabaseMethods().Storeprofile(profile.toJson(),uid);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully')),
    );

    Navigator.of(context).pop(true); // Return true to previous screen
  }

  Widget _smallField(TextEditingController ctrl, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    headlineCtrl.dispose();
    ageCtrl.dispose();
    heightCtrl.dispose();
    weightCtrl.dispose();
    genderCtrl.dispose();
    educationCtrl.dispose();
    cityCtrl.dispose();
    districtCtrl.dispose();
    stateCtrl.dispose();
    countryCtrl.dispose();
    contactCtrl.dispose();
    sportsCtrl.dispose();
    aboutCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF1E8F5E);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF39D2C0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Banner + Profile Picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: _pickBannerPhoto,
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: _bannerImagePath != null
                            ? DecorationImage(
                          image: FileImage(File(_bannerImagePath!)),
                          fit: BoxFit.cover,
                        )
                            : null,
                        gradient: _bannerImagePath == null
                            ? LinearGradient(colors: [accent, Colors.blueAccent])
                            : null,
                      ),
                      child: _bannerImagePath == null
                          ? const Center(
                        child: Icon(Icons.photo, color: Colors.white, size: 36),
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    left: 16.w,
                    bottom: -36.h,
                    child: GestureDetector(
                      onTap: _pickProfilePhoto,
                      child: CircleAvatar(
                        radius: 36.r,
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImagePath != null
                            ? FileImage(File(_profileImagePath!))
                            : null,
                        child: _profileImagePath == null
                            ? Icon(Icons.camera_alt, size: 28.sp, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              _smallField(nameCtrl, 'Full name'),
              SizedBox(height: 10.h),
              _smallField(headlineCtrl, 'Headline (e.g., Sprinter | 100m PB)'),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _smallField(ageCtrl, 'Age', keyboard: TextInputType.number),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallField(heightCtrl, 'Height (cm)', keyboard: TextInputType.number),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _smallField(weightCtrl, 'Weight (kg)', keyboard: TextInputType.number),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _smallField(genderCtrl, 'Gender'),
              SizedBox(height: 10.h),
              _smallField(educationCtrl, 'Education'),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(child: _smallField(cityCtrl, 'City')),
                  SizedBox(width: 10.w),
                  Expanded(child: _smallField(districtCtrl, 'District')),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(child: _smallField(stateCtrl, 'State')),
                  SizedBox(width: 10.w),
                  Expanded(child: _smallField(countryCtrl, 'Country')),
                ],
              ),
              SizedBox(height: 10.h),
              _smallField(contactCtrl, 'Contact number', keyboard: TextInputType.phone),
              SizedBox(height: 10.h),
              _smallField(sportsCtrl, 'Interested sports'),
              SizedBox(height: 10.h),
              TextFormField(
                controller: aboutCtrl,
                maxLines: 4,
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                decoration: InputDecoration(
                  labelText: 'About (short bio)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF39D2C0)),
                  onPressed: _pickCertificates,
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text('Upload Certificates', style: TextStyle(color: Colors.black)),
                ),
              ),
              if (_certificates.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _certificates.map((p) {
                    final name = p.split('/').last;
                    return Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, size: 18),
                          SizedBox(width: 8.w),
                          Expanded(child: Text(name, overflow: TextOverflow.ellipsis)),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              setState(() => _certificates.remove(p));
                            },
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF39D2C0),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: _saveProfile,
                  child: Text('Save Profile', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
