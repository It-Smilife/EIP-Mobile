import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsmilife/pages/normal_user/Home/bloc/home_bloc.dart';

class EmoticonCard extends StatelessWidget {
  const EmoticonCard({super.key, required this.emoticonFace, required this.mood});

  final String emoticonFace;
  final String mood;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
        context.read<HomeBloc>().add(
              MoodChangedEvent(mood: emoticonFace),
            );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: Color.fromARGB(255, 107, 146, 198),
            ),
            child: Text(
              emoticonFace,
              style: const TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            mood,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
