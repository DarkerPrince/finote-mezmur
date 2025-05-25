import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  SettingsPage({required this.isDarkMode, required this.onThemeToggle});

  final socialLinks = {
    'Facebook': 'https://facebook.com/',
    'Telegram': 'https://t.me/',
    'Instagram': 'https://instagram.com/',
  };

  void _launchURL(String url) async {
    // if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    //   throw 'Could not launch $url';
    // }
  }

  Widget _buildSocialIcon(String name, IconData icon, String url) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () => _launchURL(url),
      tooltip: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Finote Tsidk',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text(
              'Finote Tsidk is a spiritual and event-based app designed to guide users through meaningful experiences with curated content and community activities.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            Text('Follow us', style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                _buildSocialIcon('Facebook', Icons.facebook, socialLinks['Facebook']!),
                _buildSocialIcon('Telegram', Icons.telegram, socialLinks['Telegram']!),
                _buildSocialIcon('Instagram', Icons.camera_alt, socialLinks['Instagram']!),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode'),
                Switch(
                  value: isDarkMode,
                  onChanged: onThemeToggle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
