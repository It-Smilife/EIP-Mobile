import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:itsmilife/pages/normal_user/onboarding/onboarding.dart';
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
  static String role = "default";
  static bool rolestate = false;
  static int age = 0;
  static String gender = "male";
  static String phoneNumber = "0000000";
  static String address = "carrer de la moula";
  static String password = "default";
  static bool dark = false;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 1), // 1 for the border
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ),
          child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor:const Color.fromARGB(255, 255, 255, 255),
        title: Text("Modifier le profil",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
                        _formKey.currentState!.save();
                        ProfileData.lastName = _name;
                        ProfileData.firstName = _prenom;
                        ProfileData.email = _email;
                        ProfileData.age = _age;
                        ProfileData.gender = _gender;
                        ProfileData.phoneNumber = _phoneNumber;
                        ProfileData.address = _address;
                      }
                    });
                  }
                  Navigator.pop(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SettingsPage(),
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
                child: Text(
                  'Terminé',
                  style: TextStyle(
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      onPressed: () {
                        // Handle text button press
                      },
                      child: Text('Modify photo or avatar'),
                    ),
                  ),
                ],
              ),

              // Name
              Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.lastName,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _name = value!,
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.firstName,
                      decoration: InputDecoration(
                        labelText: 'Prenom',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _prenom = value!,
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.age.toString(),
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _age = int.parse(value!),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    DropdownButtonFormField(
                      value: ProfileData.gender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _phoneNumber = value!,
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: ProfileData.address,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      validator: (value) {},
                      onSaved: (value) => _address = value!,
                    ),
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
