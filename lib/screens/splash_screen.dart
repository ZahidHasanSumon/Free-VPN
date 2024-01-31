import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/helpers/helper_func.dart';
import '../main.dart';
import 'home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Uncomment the following code to navigate to HomeScreen after a delay
    Future.delayed(Duration(milliseconds: 1500), () {
      // exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);


      // navigate to home
      Get.off(() => HomeScreen());

    });
  }

  @override
  Widget build(BuildContext context) {
    // Initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    // Getting dark mode status from Pref class
    final dark = SHelperFunctions.isDarkMode(context);


    return Theme(
      data: ThemeData(
        brightness: dark ? Brightness.dark : Brightness.light,
        // Add any other theme configurations as needed
      ),
      child: Scaffold(
        // Uncomment the following line if you want to set background color based on dark mode
        // backgroundColor: dark ? Colors.black : Colors.white,
        body: Stack(
          children: [
            // App logo
            Container(
              alignment: Alignment.center,
              height: mq.height,
              width: mq.width,
              padding: EdgeInsets.zero,
              child: Image.asset(
                'assets/images/planet.gif',
                height: 300,
                width: 300,
              ),
            ),

            // Label
            Positioned(
              bottom: mq.height * 0.15,
              width: mq.width,
              child: Text(
                'Fast & Secure: Surf Beyond Your Limit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: dark ? Colors.white : Colors.black,
                  letterSpacing: 1,
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
