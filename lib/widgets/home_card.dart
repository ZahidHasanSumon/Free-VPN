import 'package:flutter/material.dart';
import 'package:vpn_basic_project/helpers/helper_func.dart';

import '../helpers/SColors.dart';
import '../main.dart';

// Card to represent status in the home screen
class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget icon;

  const HomeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Container(
      width: mq.width * 0.45,
      child: Column(
        children: [
          // Icon
          icon,

          // Adding some space
          const SizedBox(height: 6),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'SpaceGrotesk',
              overflow: TextOverflow.ellipsis,
              color: darkMode ? SColors.white : SColors.black,
            ),
          ),

          // Adding some space
          const SizedBox(height: 6),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              color: darkMode ? SColors.white : SColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'SpaceGrotesk',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
