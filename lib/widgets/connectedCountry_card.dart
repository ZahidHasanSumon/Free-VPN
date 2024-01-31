import 'package:flutter/material.dart';

import '../main.dart';

//card to represent status in home screen
class connectedCountry extends StatelessWidget {
  final String title;
  final Widget icon;

  const connectedCountry({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: mq.width * .5,
        child: Row(
          children: [
            //icon
            icon,

            //for adding some space
            const SizedBox(width: 10),

            //title
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SpaceGrotesk'),
            ),

            //for adding some space
            const SizedBox(width: 10),

            //subtitle
          ],
        ));
  }
}
