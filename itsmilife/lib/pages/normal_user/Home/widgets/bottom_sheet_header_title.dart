import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

class BottomSheetHeaderTitle extends StatelessWidget {
  final String titleText;
  const BottomSheetHeaderTitle({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: darkMode.darkMode == true ? Color.fromARGB(255, 59, 59, 59) : Color.fromARGB(255, 98, 128, 182),
            border: Border.all(
              color: darkMode.darkMode == true ? Color.fromARGB(255, 59, 59, 59) : Color.fromARGB(255, 98, 128, 182),
              width: 0,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25,
            vertical: 16,
          ),
          child: Text(
            titleText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
