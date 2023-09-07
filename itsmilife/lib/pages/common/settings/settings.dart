import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/login.dart';
import 'package:itsmilife/pages/register.dart';
import 'package:itsmilife/services/NetworkManager.dart';
// import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:itsmilife/pages/common/settings/changePass.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RoleProvider.dart';
import './package_settings/babs_component_big_user_card.dart';
import './package_settings/babs_component_settings_group.dart';
import './package_settings/babs_component_settings_item.dart';
import './package_settings/icon_style.dart';
import './package_settings/settings_screen_utils.dart';
import './package_settings/babs_component_simple_user_card.dart';
import './package_settings/babs_component_small_user_card.dart';
import 'package:itsmilife/pages/common/settings/notificationProvider.dart';

const List<String> list = <String>['English', 'Français'];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  String dropdownValue = list.first;

  void deleteUser() async {
    var id = ProfileData.id;

    await NetworkManager.delete("users/$id").then((value) {
      if (value.data["success"] == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
      }
    });
  }

  void sendMembershipRequest() {
    // Code to send a membership request goes here
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RoleProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    final notif = Provider.of<NotificationProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 255, 255, 255),
        title: Text(lang.lang == "English" ? "Settings" : "Paramètres", style: const TextStyle(color: Color.fromARGB(255, 98, 128, 182), fontSize: 25, fontWeight: FontWeight.bold)),
        leading: Icon(CupertinoIcons.add, color: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: const Color.fromARGB(255, 98, 128, 182),
              userName: ProfileData.username == "" ? "Default name" : ProfileData.username,
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
                      pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
              settingsGroupTitleStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  icons: Icons.assignment_ind,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.green,
                  ),
                  title: lang.lang == "English" ? "Professional mode" : "Mode professionnelle",
                  trailing: Switch.adaptive(
                    value: user.Setrolestate,
                    onChanged: (value) {
                      if (user.Setrole == "professional") {
                        // L'utilisateur est un administrateur, on peut modifier l'état du switch
                        setState(() {
                          user.Setrolestate = value;
                        });
                      } else {
                        // L'utilisateur n'est pas un administrateur, on affiche la fenêtre de demande d'adhésion
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Demande d'adhésion" + user.Setrole.toString()),
                            content: const Text("Voulez-vous envoyer une demande d'adhésion pour activer le mode professionnel ?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Annuler'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Envoyer la demande d'adhésion
                                  sendMembershipRequest();
                                  // Afficher un message de confirmation
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Membership request sent successfully'),
                                  ));
                                  Navigator.pop(context);
                                },
                                child: Text('Envoyer'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.text_bubble,
                  iconStyle: IconStyle(),
                  title: lang.lang == "English" ? "Language" : "Langue",
                  titleStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                  trailing: DropdownButton<String>(
                    value: lang.lang,
                    icon: Icon(CupertinoIcons.arrow_down, color: darkMode.darkMode ? Colors.white : Colors.grey),
                    elevation: 16,
                    style: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 0,
                      color: Colors.grey,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        lang.lang = value!;
                        NetworkManager.put("users/" + ProfileData.id, {
                          "language": value,
                        }).then((val) {
                          if (val.data['success'] == true) {}
                        });
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: darkMode.darkMode ? Color.fromARGB(255, 161, 161, 161) : const Color.fromARGB(255, 70, 70, 70), fontWeight: FontWeight.bold),
                        ),
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
                      NetworkManager.put("users/" + ProfileData.id, {
                        "dark": value,
                      }).then((val) {
                        if (val.data['success'] == true) {}
                      });
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: lang.lang == "English" ? "Security" : "Sécurité",
              settingsGroupTitleStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChangePassPage()),
                    );
                  },
                  icons: Icons.lock,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: lang.lang == "English" ? "Change password" : "Changer le mot de passe",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.bell,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  title: lang.lang == "English" ? "Enable notifications" : "Activer les notifications",
                  trailing: Switch.adaptive(
                    value: notif.notif,
                    onChanged: (value) {
                      notif.notif = value;
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: lang.lang == "English" ? "Account" : "Compte",
              settingsGroupTitleStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              items: [
                SettingsItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 20, right: 20, left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      lang.lang == "English" ? "Log out" : "Se déconnecter",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      lang.lang == "English" ? "Are you sure that you want to log out" : "Êtes-vous sur de vouloir vous déconnecter ?",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                          onPressed: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()))},
                                          child: Text(
                                            lang.lang == "English" ? "yes" : "Oui",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          onPressed: () => {Navigator.pop(context)},
                                          child: Text(
                                            lang.lang == "English" ? "Cancel" : "Anuler",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: lang.lang == "English" ? "Sign out" : "Se déconnecter",
                ),
                SettingsItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 20, right: 10, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      lang.lang == "English" ? "Delete account" : "Suppression du compte",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      lang.lang == "English" ? "Are you sure that you want to delete this account ?" : "Êtes-vous sur de vouloir supprimer ce compte ?",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                          onPressed: () => {deleteUser()},
                                          child: Text(
                                            lang.lang == "English" ? "yes" : "Oui",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          onPressed: () => {Navigator.pop(context)},
                                          child: Text(
                                            lang.lang == "English" ? "Cancel" : "Anuler",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: lang.lang == "English" ? "Delete account" : "Supprimer le compte",
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
                  onTap: () {
                    launchUrl(Uri.parse("http://eip.epitech.eu/2024/itsmilife"));
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                  ),
                  title: lang.lang == "English" ? "About" : "A propos",
                  subtitle: lang.lang == "English" ? "Learn more about It'smilife" : "Apprenez-en plus à propose de It'smilife",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
