import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class ContactUsDialog extends StatelessWidget {
  const ContactUsDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => const ContactUsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Contact Us"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "We’re here to help! If you have questions, feedback, or need assistance using EduGate, feel free to reach out:",
          ),
          SizedBox(height: 16),

          Text("Phone:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("+201098138067"),
          SizedBox(height: 16),
          Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("support@edugateapp.com"),
          SizedBox(height: 16),

          Text(
            "Need quick answers? Visit our Help Center in the app or chat with us directly.",
          ),
        ],
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
