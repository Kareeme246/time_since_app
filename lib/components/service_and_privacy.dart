import 'package:flutter/material.dart';
import 'package:time_since_app/app_theme.dart';

Widget termsOfServiceContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.white1,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '1. Acceptance of Terms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'By using this application, you agree to comply with and be bound by the following terms of service. If you do not agree to these terms, please do not use the app.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '2. Use of the Application',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This application is provided for personal use only. You may not use the app for any unlawful purposes or in violation of any applicable laws.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '3. Modifications to Terms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We reserve the right to modify these terms at any time. Your continued use of the app after changes are made constitutes acceptance of the new terms.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '4. Disclaimer of Warranties',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This app is provided on an "as-is" basis. We make no warranties, expressed or implied, regarding the app\'s reliability, accuracy, or availability.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '5. Limitation of Liability',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Under no circumstances shall we be held liable for any damages arising out of the use of this app, including but not limited to incidental or consequential damages.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '6. Governing Law',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'These terms of service are governed by and construed in accordance with the laws of your country, without regard to conflict of law principles.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
      ],
    ),
  );
}

Widget privacyPolicyContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.white1,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '1. Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This application values your privacy. We do not collect any personal data. All data generated within the app is stored locally on your device and never transmitted to external servers.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '2. Local Data Storage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'All data, including preferences, settings, and any other app-related information, is stored locally on your device. This means that you have full control over your data at all times.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '3. No Third-Party Access',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This application does not share any data with third-party entities. Your privacy is completely protected.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '4. Data Security',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We take reasonable steps to ensure that the data stored locally on your device is protected. However, we cannot guarantee the security of your device.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          '5. Changes to the Privacy Policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We reserve the right to update this privacy policy from time to time. Any changes will be reflected in the application.',
          style: TextStyle(color: AppTheme.white1, fontSize: 16),
        ),
      ],
    ),
  );
}
