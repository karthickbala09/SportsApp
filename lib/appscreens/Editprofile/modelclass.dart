class ProfileModel {
  String name;
  String headline;
  String? profileImagePath;
  String? bannerImagePath;
  String? age;
  String? height;
  String? weight;
  String? gender;
  String? education;
  String? city;
  String? district; // added district
  String? state;
  String? country;
  String? contact;
  String? interestedSports;
  String about;
  List<String> certificates;

  ProfileModel({
    this.name = '',
    this.headline = '',
    this.profileImagePath,
    this.bannerImagePath,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.education,
    this.city,
    this.district, // added district
    this.state,
    this.country,
    this.contact,
    this.interestedSports,
    this.about = '',
    this.certificates = const [],
  });

  // Empty constructor
  factory ProfileModel.empty() {
    return ProfileModel();
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      headline: json['headline'] ?? '',
      profileImagePath: json['profileImagePath'],
      bannerImagePath: json['bannerImagePath'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      education: json['education'],
      city: json['city'],
      district: json['district'], // added district
      state: json['state'],
      country: json['country'],
      contact: json['contact'],
      interestedSports: json['interestedSports'],
      about: json['about'] ?? '',
      certificates: List<String>.from(json['certificates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'headline': headline,
    'profileImagePath': profileImagePath,
    'bannerImagePath': bannerImagePath,
    'age': age,
    'height': height,
    'weight': weight,
    'gender': gender,
    'education': education,
    'city': city,
    'district': district, // added district
    'state': state,
    'country': country,
    'contact': contact,
    'interestedSports': interestedSports,
    'about': about,
    'certificates': certificates,
  };
}
