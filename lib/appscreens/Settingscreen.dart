import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences prefs;

  // Settings
  bool animationsEnabled = true;
  bool pushNotifications = true;
  bool soundAlerts = false;
  bool vibrationAlerts = true;
  bool badgesEnabled = true;
  bool leaderboardEnabled = false;
  bool consentGiven = true;
  String dataSharing = "SAI Only";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      animationsEnabled = prefs.getBool('animationsEnabled') ?? true;
      pushNotifications = prefs.getBool('pushNotifications') ?? true;
      soundAlerts = prefs.getBool('soundAlerts') ?? false;
      vibrationAlerts = prefs.getBool('vibrationAlerts') ?? true;
      badgesEnabled = prefs.getBool('badgesEnabled') ?? true;
      leaderboardEnabled = prefs.getBool('leaderboardEnabled') ?? false;
      consentGiven = prefs.getBool('consentGiven') ?? true;
      dataSharing = prefs.getString('dataSharing') ?? "SAI Only";
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  Widget sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(icon, color: Colors.blue, size: 22.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1.h),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFF39D2C0),
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // App Behavior
                  sectionCard(
                    title: "App Behavior & Performance",
                    icon: Icons.speed,
                    children: [
                      SwitchListTile(
                        title: Text("Enable Animations",
                            style: TextStyle(fontSize: 14.sp)),
                        value: animationsEnabled,
                        onChanged: (val) {
                          setState(() => animationsEnabled = val);
                          _saveSetting("animationsEnabled", val);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.delete_outline, size: 22.sp),
                        title: Text(
                            "Clear Cache", style: TextStyle(fontSize: 14.sp)),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Cache cleared ✅")),
                          );
                        },
                      ),
                    ],
                  ),

                  // Notifications
                  sectionCard(
                    title: "Notifications & Alerts",
                    icon: Icons.notifications,
                    children: [
                      SwitchListTile(
                        title: Text("Push Notifications",
                            style: TextStyle(fontSize: 14.sp)),
                        value: pushNotifications,
                        onChanged: (val) {
                          setState(() => pushNotifications = val);
                          _saveSetting("pushNotifications", val);
                        },
                      ),
                      SwitchListTile(
                        title: Text(
                            "Sound Alerts", style: TextStyle(fontSize: 14.sp)),
                        value: soundAlerts,
                        onChanged: (val) {
                          setState(() => soundAlerts = val);
                          _saveSetting("soundAlerts", val);
                        },
                      ),
                      SwitchListTile(
                        title: Text("Vibration Alerts",
                            style: TextStyle(fontSize: 14.sp)),
                        value: vibrationAlerts,
                        onChanged: (val) {
                          setState(() => vibrationAlerts = val);
                          _saveSetting("vibrationAlerts", val);
                        },
                      ),
                    ],
                  ),

                  // Security & Privacy
                  sectionCard(
                    title: "Security & Privacy",
                    icon: Icons.security,
                    children: [
                      ListTile(
                        leading: Icon(Icons.lock_reset, size: 22.sp),
                        title: Text("Reset Password",
                            style: TextStyle(fontSize: 14.sp)),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                "Password reset link sent 📩")),
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text("Data Sharing Preference",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.sp)),
                      RadioListTile(
                        title: Text("Share with SAI only",
                            style: TextStyle(fontSize: 13.sp)),
                        value: "SAI Only",
                        groupValue: dataSharing,
                        onChanged: (val) {
                          setState(() => dataSharing = val!);
                          _saveSetting("dataSharing", val);
                        },
                      ),
                      RadioListTile(
                        title: Text("Anonymized Benchmarking",
                            style: TextStyle(fontSize: 13.sp)),
                        value: "Anonymized",
                        groupValue: dataSharing,
                        onChanged: (val) {
                          setState(() => dataSharing = val!);
                          _saveSetting("dataSharing", val);
                        },
                      ),
                      SwitchListTile(
                        title: Text(
                            "Consent Given", style: TextStyle(fontSize: 14.sp)),
                        value: consentGiven,
                        onChanged: (val) {
                          setState(() => consentGiven = val);
                          _saveSetting("consentGiven", val);
                        },
                      ),
                    ],
                  ),

                  // Support
                  sectionCard(
                    title: "Support & Help",
                    icon: Icons.help_outline,
                    children: [
                      ListTile(
                        leading: Icon(Icons.book, size: 22.sp),
                        title: Text("FAQ", style: TextStyle(fontSize: 14.sp)),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("FAQ opened 📘")),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.email, size: 22.sp),
                        title: Text(
                            "Email Support", style: TextStyle(fontSize: 14.sp)),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Support email sent")),
                          );
                        },
                      ),
                    ],
                  ),

                  // Gamification
                  sectionCard(
                    title: "Gamification Controls",
                    icon: Icons.emoji_events,
                    children: [
                      SwitchListTile(
                        title: Text(
                            "Enable Badges", style: TextStyle(fontSize: 14.sp)),
                        value: badgesEnabled,
                        onChanged: (val) {
                          setState(() => badgesEnabled = val);
                          _saveSetting("badgesEnabled", val);
                        },
                      ),
                      SwitchListTile(
                        title: Text("Enable Leaderboard",
                            style: TextStyle(fontSize: 14.sp)),
                        value: leaderboardEnabled,
                        onChanged: (val) {
                          setState(() => leaderboardEnabled = val);
                          _saveSetting("leaderboardEnabled", val);
                        },
                      ),
                    ],
                  ),

                  // App Info
                  sectionCard(
                    title: "App Information",
                    icon: Icons.info,
                    children: [
                      ListTile(
                        leading: Icon(Icons.apps, size: 22.sp),
                        title: Text(
                            "Version", style: TextStyle(fontSize: 14.sp)),
                        subtitle: Text(
                            "1.0.0", style: TextStyle(fontSize: 12.sp)),
                      ),
                      ListTile(
                        leading: Icon(Icons.developer_mode, size: 22.sp),
                        title: Text(
                            "Developer", style: TextStyle(fontSize: 14.sp)),
                        subtitle: Text("Sports Talent Team",
                            style: TextStyle(fontSize: 12.sp)),
                      ),
                      ListTile(
                        leading: Icon(Icons.book, size: 22.sp),
                        title: Text(
                            "Licenses", style: TextStyle(fontSize: 14.sp)),
                        subtitle: Text("Open source dependencies",
                            style: TextStyle(fontSize: 12.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
