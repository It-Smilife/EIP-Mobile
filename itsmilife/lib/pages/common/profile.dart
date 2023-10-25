import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/avatarProvider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import '../../services/NetworkManager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileData {
  static String id = "default";
  static String avatar = "default";
  static String lastName = "default";
  static String username = "default";
  static String firstName = "default";
  static String email = "usertest@user.com";
  static String role = "user";
  static bool rolestate = false;
  static int age = 0;
  static String gender = "male";
  static String phoneNumber = "0000000";
  static String address = "";
  static String password = "default";
  static bool dark = false;
  static String language = "Français";
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late String _name = "";
  late String _prenom = "";
  late String _email = "";
  late int _age = 0;
  late String _gender = "";
  late String _phoneNumber = "";
  late String _address = "";

  List<String> imageNames = [
    "photo-fille1.png",
    "photo-fille2.png",
    "photo-fille3.png",
    "photo-fille4.png",
    "photo-fille5.png",
    "photo-fille6.png",
    "photo-fille7.png",
    "photo-fille8.png",
    "photo-garcon1.png",
    "photo-garcon2.png",
    "photo-garcon3.png",
    "photo-garcon4.png",
    "photo-garcon5.png",
    "photo-garcon6.png",
    "photo-garcon7.png",
    "photo-garcon8.png",
  ];

  void _openImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Sélectionnez une image", textAlign: TextAlign.center),
          children: [
            Container(
              width: double.maxFinite,
              height: 300, // Ajustez la hauteur en fonction de vos besoins
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes dans la grille
                ),
                itemCount: imageNames.length,
                itemBuilder: (BuildContext context, int index) {
                  final imageName = imageNames[index];
                  return SimpleDialogOption(
                    onPressed: () {
                      // Mettez à jour ProfileData.avatar avec l'image sélectionnée
                      String selectedImage = imageName;
                      // Effectuez une requête PUT pour mettre à jour le serveur avec la nouvelle image
                      Provider.of<AvatarProvider>(context, listen: false).updateAvatar(selectedImage);
                      NetworkManager.put("users/" + ProfileData.id, {"avatar": selectedImage});
                      ProfileData.avatar = selectedImage;
                      Navigator.of(context).pop(); // Fermez le dialog
                    },
                    child: Image.asset(
                      "assets/$imageName",
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 246, 246, 246),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 0.9), // 1 for the border
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 246, 246, 246),
              ),
            ),
          ),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: darkMode.darkMode ? const Color.fromARGB(255, 246, 246, 246) : const Color.fromARGB(255, 98, 128, 182),
            ),
            centerTitle: true,
            backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 234, 234, 234),
            title:
                Text(lang.lang == "English" ? "Edit the profile" : "Modifier le profil", style: const TextStyle(color: Color.fromARGB(255, 98, 128, 182), fontSize: 25, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ProfileData.lastName = _name;
                    ProfileData.firstName = _prenom;
                    ProfileData.email = _email;
                    ProfileData.age = _age;
                    ProfileData.gender = _gender;
                    ProfileData.phoneNumber = _phoneNumber;
                    ProfileData.address = _address;
                    NetworkManager.put(
                            "users/" + ProfileData.id, {"firstName": _name, "lastName": _prenom, "email": _email, "age": _age, "gender": _gender, "phoneNumber": _phoneNumber, "address": _address})
                        .then((val) {
                      if (val.data['success'] == true) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Modification du profile"),
                              content: const Text("Votre profile à bien été modifié"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkMode.darkMode ? Color.fromARGB(255, 108, 108, 108) : Color.fromARGB(255, 98, 128, 182), // Changer la couleur ici
                ),
                child: Text(
                  lang.lang == "English" ? "Save" : "Terminé",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  width: 0,
                  height: 20,
                ),
                // Avatar
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _openImagePickerDialog(context);
                          },
                          child: SizedBox(
                            width: 190,
                            height: 140,
                            child: FutureBuilder<Uint8List>(
                              future: NetworkManager.getFile(Provider.of<AvatarProvider>(context).avatar),
                              builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: MemoryImage(snapshot.data ?? Uint8List(0)),
                                        fit: BoxFit.contain,
                                      ),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Text('Une erreur est survenue : ${snapshot.error}');
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.030)
                  ],
                ),

                // Name
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.024),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkMode.darkMode ? Color.fromARGB(255, 79, 79, 79) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Color.fromARGB(255, 98, 128, 182),
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.lang == "English" ? "Laste name" : "Nom",
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.lastName,
                            decoration: InputDecoration(
                                border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true, labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Le nom ne doit pas être vide';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value!,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            lang.lang == "English" ? "First name" : "Prénom",
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.firstName,
                            decoration: InputDecoration(
                                border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true, labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Le prenom ne doit pas être vide';
                              }
                              return null;
                            },
                            onSaved: (value) => _prenom = value!,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.email,
                            decoration: InputDecoration(
                                border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true, labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            validator: (value) {},
                            onSaved: (value) => _email = value!,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Age',
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.age.toString(),
                            decoration: InputDecoration(
                                border: InputBorder.none, contentPadding: EdgeInsets.zero, isDense: true, labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'L\'âge ne doit pas être vide';
                              }
                              final n = int.tryParse(value);
                              if (n == null || n == 0) {
                                return 'L\'âge doit être un nombre entier valide';
                              }
                              return null;
                            },
                            onSaved: (value) => _age = int.parse(value!),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            lang.lang == "English" ? "Gender" : "Genre",
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField(
                            value: ProfileData.gender,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                            onSaved: (value) => _gender = value!,
                            items: [
                              ['male', 'homme'],
                              ['female', 'femme'],
                              ['other', 'autres']
                            ].map((value) {
                              return DropdownMenuItem(
                                value: value[0],
                                child: lang.lang == "English" ? Text(value[0]) : Text(value[1]),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                          ),
                          const SizedBox(height: 5),
                          Text(
                            lang.lang == "English" ? "Phone number" : "Numéro de Téléphone",
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.phoneNumber,
                            decoration: InputDecoration(
                                hintText: lang.lang == "English" ? "Enter your phone number" : "Entrez un numéro de téléphone",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              final regex = RegExp(r'^\+?\d{9,15}$');
                              if (!regex.hasMatch(value!)) {
                                return 'Le numéro de téléphone doit être un format valide';
                              }
                              return null;
                            },
                            onSaved: (value) => _phoneNumber = value!,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            lang.lang == "English" ? "Address" : "Adresse",
                            style: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            initialValue: ProfileData.address,
                            decoration: InputDecoration(
                                hintText: lang.lang == "English" ? "Enter your adress" : "Entrez une adresse",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                labelStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black)),
                            maxLines: 1,
                            validator: (value) {},
                            onSaved: (value) => _address = value!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
