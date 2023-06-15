import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  const Date({
    super.key,
  });

  @override
 Widget build(BuildContext context) {
  var formattedDate = DateFormat.yMMMMd('fr_FR').format(DateTime.now());

  return Text(
    formattedDate,
    style: TextStyle(
      color: Color.fromARGB(255, 224, 224, 224),
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
    ),
  );
}
}
