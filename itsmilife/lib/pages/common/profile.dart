import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings.dart';

class ProfileData {
  static String id = "";
  static String avatar = "";
  static String name = "User_test";
  static String email = "usertest@user.com";
  static int age = 0;
  static String gender = "Male";
  static String phoneNumber = "+6 33 67 87 67";
  static String address = "carrer de la moula";
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _email;
  late int _age;
  late String _gender;
  late String _phoneNumber;
  late String _address;
  // You can use a package like image_picker to handle the avatar image
  // and save it to the user's device or cloud storage.
  // For this example, we will just use a variable to hold the avatar path.
  String _avatar = 'assets/logo.png';

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black,
            ),
            title: Text(
              'Modifier profil',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ProfileData.name = _name;
                    ProfileData.email = _email;
                    ProfileData.age = _age;
                    ProfileData.gender = _gender;
                    ProfileData.phoneNumber = _phoneNumber;
                    ProfileData.address = _address;
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
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
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
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: TextFormField(
                  initialValue: ProfileData.name,
                  decoration: InputDecoration(
                    labelText: '  Name',
                  ),
                  validator: (value) {},
                  onSaved: (value) => _name = value!,
                ),
              ),

              // Email
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.25, color: Colors.grey))),
                child: TextFormField(
                  initialValue: ProfileData.email,
                  decoration: InputDecoration(
                    labelText: '  Email',
                  ),
                  validator: (value) {},
                  onSaved: (value) => _email = value!,
                ),
              ),
              // Age
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.25, color: Colors.grey))),
                child: TextFormField(
                  initialValue: ProfileData.age.toString(),
                  decoration: InputDecoration(
                    labelText: '  Age',
                  ),
                  validator: (value) {},
                  onSaved: (value) => _age = int.parse(value!),
                ),
              ),
              // Gender
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.25, color: Colors.grey))),
                child: DropdownButtonFormField(
                  value: ProfileData.gender,
                  decoration: InputDecoration(
                    labelText: '  Gender',
                  ),
                  onSaved: (value) => _gender = value!,
                  items: ['Male', 'Female', 'Other'].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text('  ' + value),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
                ),
              ),

// Phone Number
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.25, color: Colors.grey))),
                child: TextFormField(
                  initialValue: ProfileData.phoneNumber,
                  decoration: InputDecoration(
                    labelText: '  Phone Number',
                  ),
                  validator: (value) {},
                  onSaved: (value) => _phoneNumber = value!,
                ),
              ),
// Address
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.25, color: Colors.grey),
                        bottom: BorderSide(width: 0.25, color: Colors.grey))),
                child: TextFormField(
                  initialValue: ProfileData.address,
                  decoration: InputDecoration(
                    labelText: '  Address',
                  ),
                  validator: (value) {},
                  onSaved: (value) => _address = value!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
