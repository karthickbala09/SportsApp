// lib/models/profile_model.dart
class ProfileModel {
  String name;
  String headline; // e.g., "Sprinter | 100m PB: 10.8s"
  String age;
  String gender;
  String education;
  String city;
  String district;
  String state;
  String country;
  String contact;
  String interestedSports;
  String about;
  String? profileImagePath;  // local file path
  String? bannerImagePath;   // local file path
  List<String> certificates; // local file paths

  ProfileModel({
    this.name = '',
    this.headline = '',
    this.age = '',
    this.gender = '',
    this.education = '',
    this.city = '',
    this.district = '',
    this.state = '',
    this.country = '',
    this.contact = '',
    this.interestedSports = '',
    this.about = '',
    this.profileImagePath,
    this.bannerImagePath,
    this.certificates = const [],
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'headline': headline,
    'age': age,
    'gender': gender,
    'education': education,
    'city': city,
    'district': district,
    'state': state,
    'country': country,
    'contact': contact,
    'interestedSports': interestedSports,
    'about': about,
    'profileImagePath': profileImagePath ?? '',
    'bannerImagePath': bannerImagePath ?? '',
    'certificates': certificates,
  };

  // Convert JSON to object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      headline: json['headline'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      education: json['education'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      contact: json['contact'] ?? '',
      interestedSports: json['interestedSports'] ?? '',
      about: json['about'] ?? '',
      profileImagePath:
      (json['profileImagePath'] ?? '').toString().isEmpty ? null : json['profileImagePath'],
      bannerImagePath:
      (json['bannerImagePath'] ?? '').toString().isEmpty ? null : json['bannerImagePath'],
      certificates: List<String>.from(json['certificates'] ?? []),
    );
  }
}
