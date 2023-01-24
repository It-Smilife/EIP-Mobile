import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:itsmilife/pages/common/settings/changePass.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
import '../../normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

const List<String> list = <String>['English', 'Français'];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
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
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              cardColor: const Color.fromARGB(255, 98, 128, 182),
              userName: "User name",
              userProfilePic: const AssetImage("assets/logo.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: lang.lang == "English" ? "Edit profile" : "Modifier le profil",
                subtitle: lang.lang == "English" ? "Tap to edit yout profile" : "Cliquez pour modifier le profil",
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ProfilePage(),
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
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: lang.lang == "English" ? "Common" : "Commun",
              settingsGroupTitleStyle: TextStyle(
                  color: darkMode.darkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.text_bubble,
                  iconStyle: IconStyle(),
                  title: lang.lang == "English" ? "Language" : "Langue",
                  titleStyle: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  trailing: DropdownButton<String>(
                    value: lang.lang,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 0,
                      color: Colors.grey,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        lang.lang = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: lang.lang == "English" ? "Dark mode" : "Mode sombre",
                  trailing: Switch.adaptive(
                    value: darkMode.darkMode,
                    onChanged: (value) {
                      darkMode.darkMode = value;
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle:
                  lang.lang == "English" ? "Security" : "Sécurité",
              settingsGroupTitleStyle: TextStyle(
                  color: darkMode.darkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePassPage()),
                    );
                  },
                  icons: Icons.lock,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: lang.lang == "English"
                      ? "Change password"
                      : "Changer le mot de passe",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.bell,
                  // iconStyle: IconStyle(
                  //   backgroundColor: Colors.purple,
                  // ),
                  title: lang.lang == "English"
                      ? "Enable notifications"
                      : "Activer les notifications",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: lang.lang == "English" ? "Account" : "Compte",
              settingsGroupTitleStyle: TextStyle(
                  color: darkMode.darkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: lang.lang == "English" ? "Sign out" : "Se déconnecter",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: lang.lang == "English"
                      ? "Delete account"
                      : "Supprimer le compte",
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
                  title: lang.lang == "English" ? "About" : "A propos",
                  subtitle: lang.lang == "English"
                      ? "Learn more about It'smilife"
                      : "Apprenez-en plus à propose de It'smilife",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
