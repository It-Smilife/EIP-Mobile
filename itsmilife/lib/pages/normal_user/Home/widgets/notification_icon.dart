import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        15.0,
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 107, 146, 198),
          borderRadius: const BorderRadius.all(Radius.circular(
            20.0,
          ))),
      child: const Icon(
        CupertinoIcons.bell_fill,
        size: 28.0,
        color: Colors.white,
      ),
    );
  }
}
