import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const AboutUsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("About Us"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Our Company", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              "EduGate is your gateway to higher education in Egypt."
              "We make it easy to explore universities, apply online, and find scholarships—all in one app."
              "With real-time tracking and personalized guidance, EduGate helps you take control of your academic journey with confidence and ease.",
            ),
            SizedBox(height: 16),
            Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Email:  support@edugateapp.com"),
            Text("Phone: +201098138067"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "CLOSE",
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
