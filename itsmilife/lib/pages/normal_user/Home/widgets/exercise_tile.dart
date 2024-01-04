import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.subExercise,
    required this.icon,
    required this.color,
  });

  final String exercise;
  final String subExercise;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: darkMode.darkMode ? Color.fromARGB(255, 59, 59, 59) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: color,
                    ),
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkMode.darkMode ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
