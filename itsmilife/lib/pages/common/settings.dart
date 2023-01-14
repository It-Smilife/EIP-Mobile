import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Dark mode'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('Edit profile'),
                leading: const Icon(Icons.account_circle)
              ),
              SettingsTile(
                title: const Text('Email'),
                leading: const Icon(Icons.email)
              ),
              SettingsTile(
                title: const Text('User info'),
                leading: const Icon(Icons.info)
              ),
              SettingsTile(
                title: const Text('Log out'),
                leading: const Icon(Icons.logout)
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.lock),
                title: const Text('Change password'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.notifications),
                title: const Text('Enable notifications'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
