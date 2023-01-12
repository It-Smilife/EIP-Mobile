import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  const PatientList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientList'),
      ),
      body: const Text("PatientList content"),
    );
  }
}