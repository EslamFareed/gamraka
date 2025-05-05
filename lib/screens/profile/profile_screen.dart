import 'package:flutter/material.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/auth/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        title: Text("Logout"),
        onTap: () async {
          await CacheHelper.sharedPreferences.clear();
          context.goOffAll(LoginScreen());
        },
      ),
    );
  }
}
