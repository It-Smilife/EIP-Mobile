import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import '../../services/NetworkManager.dart';

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
  // You can use a package like image_picker to handle the avatar image
  // and save it to the user's device or cloud storage.
  // For this example, we will just use a variable to hold the avatar path.
  String _avatar = 'assets/logo.png';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
          resizeToAvoidBottomInset: false, 
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 0.9), // 1 for the border
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Color.fromARGB(255, 98, 128, 182),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: Text(
              lang.lang == "English" ? "Edit the profile" : "Modifier le profil",
                style: const TextStyle(
                    color: Color.fromARGB(255, 98, 128, 182),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ProfileData.lastName = _name;
                    ProfileData.firstName = _prenom;
                    ProfileData.email = _email;
                    ProfileData.age = _age;
                    ProfileData.gender = _gender;
                    ProfileData.phoneNumber = _phoneNumber;
                    ProfileData.address = _address;
                    NetworkManager.put("users/" + ProfileData.id, {
                      "firstName": _name,
                      "lastName": _prenom,
                      "email": _email,
                      "age": _age,
                      "gender": _gender,
                      "phoneNumber": _phoneNumber,
                      "address": _address
                    }).then((val) {
                      if (val.data['success'] == true) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Modification du profile"),
                              content:
                                  const Text("Votre profile à bien été modifié"),
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
      body:  Padding(
        padding: const EdgeInsets.all(0),
        child:  Form(
          key: _formKey,
          child: SingleChildScrollView(child: Column(
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
                      Container(
                        width: 190,
                        height: 140,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 200,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(_avatar),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            ),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 98, 128, 182),
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
                          lang.lang == "English" ? "Last name" : "Nom",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: ProfileData.lastName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          validator: (value) {},
                          onSaved: (value) => _name = value!,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lang.lang == "English" ? "First name" : "Prénom",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: ProfileData.firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          validator: (value) {},
                          onSaved: (value) => _prenom = value!,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: ProfileData.email,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          validator: (value) {},
                          onSaved: (value) => _email = value!,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Age',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: ProfileData.age.toString(),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          validator: (value) {},
                          onSaved: (value) => _age = int.parse(value!),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lang.lang == "English" ? "Gender" : "Genre",
                          style: const TextStyle(
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
                              child: lang.lang == "English"
                                  ? Text(value[0])
                                  : Text(value[1]),
                            );
                          }).toList(),
                          onChanged: (String? value) {},
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lang.lang == "English" ? "Phone number" : "Numéro de Téléphone",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height:5),
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {},
                          onSaved: (value) => _phoneNumber = value!,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lang.lang == "English" ? "Address" : "Adresse",
                          style: const TextStyle(
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                          ),
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
