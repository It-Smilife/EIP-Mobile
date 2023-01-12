import 'package:flutter/material.dart';

class Discussions extends StatelessWidget {
  const Discussions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'),
      ),
      body: const Text("Discussions content"),
    );
  }
}