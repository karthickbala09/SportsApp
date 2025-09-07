import 'package:flutter/material.dart';
import 'package:sihapp/appscreens/Editprofile/viewprofile.dart';
import 'editprofilescreen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sports Profile App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Edit Profile"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("View Profile"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ViewProfileScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
