import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              cardColor: const Color.fromARGB(255, 98, 128, 182),
              userName: "User name",
              userProfilePic: AssetImage("assets/logo.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Edit Profile",
                subtitle: "Tap to edit your profile",
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProfilePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: "Common",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.text_bubble,
                  iconStyle: IconStyle(),
                  title: 'Language',
                  subtitle: "English",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Security",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.lock,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Change password',
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.bell,
                  // iconStyle: IconStyle(
                  //   backgroundColor: Colors.purple,
                  // ),
                  title: 'Enable notifications',
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                  ),
                  title: 'About',
                  subtitle: "Learn more about It'smilife",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
