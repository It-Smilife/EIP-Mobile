import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String content;

  const Answer(this.selectHandler, this.content, {Key? key}) : super(key: key);

 @override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ElevatedButton(
          child: Text(content, style: const TextStyle(fontSize: 18, fontFamily: 'Fontstart')),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 98, 128, 182),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            fixedSize: Size(150, 80), // Définissez la taille fixe ici (largeur x hauteur)
          ),
          onPressed: () => selectHandler(),
        ),
      ],
    ),
  );
}

}