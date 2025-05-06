import 'package:flutter/material.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/ask/asks_screen.dart';
import 'package:gamraka/screens/auth/login/login_screen.dart';

import 'about_us_dialog.dart';
import 'contact_us_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          child: Column(
            children: [
              SizedBox(height: context.height * .02),
              Container(
                margin: EdgeInsets.all(24),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  image: DecorationImage(
                    image: NetworkImage(CacheHelper.getImage()),
                  ),
                ),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.grey.withValues(alpha: .2),
                    border: Border.all(color: AppColors.primary),
                  ),
                ),
              ),
              Text(
                CacheHelper.getName(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),

              Container(
                width: context.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.phone, color: Colors.grey),
                    Text(CacheHelper.getPhone()),
                  ],
                ),
              ),
              Container(
                width: context.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.perm_identity, color: Colors.grey),
                    Text(CacheHelper.getIdNumber()),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.goToPage(AsksScreen());
                },
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.question_mark, color: Colors.grey),
                      Text("Have A Question??"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AboutUsDialog.show(context);
                },
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.info, color: Colors.grey),
                      Text("About our Company"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ContactUsDialog.show(context);
                },
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.contact_support, color: Colors.grey),
                      Text("Contact Info"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await CacheHelper.sharedPreferences.clear();
                                context.goOffAll(LoginScreen());
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.logout, color: Colors.grey),
                      Text("Logout"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
