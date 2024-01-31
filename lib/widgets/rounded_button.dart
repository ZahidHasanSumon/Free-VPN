import 'package:flutter/material.dart';
import 'package:vpn_basic_project/helpers/helper_func.dart';

import '../helpers/SColors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;


  const ButtonWidget({
    Key? key, required this.onPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    return ElevatedButton(
      onPressed:  onPressed,
      style: ElevatedButton.styleFrom(
        //primary: Colors.transparent,
        backgroundColor: darkMode ? Colors.transparent : SColors.greenlight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(width: 1.0, color: SColors.white),

        ),
      ),
      child: Text(
        "Details",
        style: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
