import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/SColors.dart';
import 'package:vpn_basic_project/helpers/helper_func.dart';
import '../controllers/home_controller.dart';
import '../main.dart';

import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/connectedCountry_card.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import '../widgets/rounded_button.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final darkMode = SHelperFunctions.isDarkMode(context);
    mq = MediaQuery.of(context).size;

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      bottomNavigationBar: _changeLocation(context, darkMode),

      //body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //vpn button
          Obx(() => _vpnButton(darkMode)),

          // Obx(
          //   () => Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       //ping time
          //       HomeCard(
          //           title: _controller.vpn.value.countryLong.isEmpty
          //               ? '100 ms'
          //               : '${_controller.vpn.value.ping} ms',
          //           subtitle: 'PING',
          //           icon: CircleAvatar(
          //             radius: 30,
          //             backgroundColor: Colors.orange,
          //             child:
          //                 Icon(Iconsax.chart_21, size: 30, color: Colors.white),
          //           )),
          //     ],
          //   ),
          // ),

          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: Get.width,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: darkMode ? SColors.white : SColors.powerButton),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //download
                          HomeCard(
                            title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                            subtitle: 'Download',
                            icon: CircleAvatar(
                              radius: 30,
                              //backgroundColor: Colors.lightGreen,
                              child: SvgPicture.asset(
                                "assets/images/download.svg",
                                fit: BoxFit.contain,

                                width: 60, // Set a specific width
                                height: 60,
                              ),
                            ),
                          ),

                          //upload
                          HomeCard(
                            title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                            subtitle: 'Upload',
                            icon: CircleAvatar(
                              radius: 30,
                              //backgroundColor: Colors.lightGreen,
                              child: SvgPicture.asset(
                                "assets/images/upload.svg",
                                fit: BoxFit.contain,
                                width: 60, // Set a specific width
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //vpn button
  Widget _vpnButton(bool darkMode) => Column(
        children: [
          //count down timer
          Container(
            height: 75,
            width: 140,
            decoration: BoxDecoration(
              color: darkMode ? SColors.darkmode : SColors.white,
            ),
            child: Obx(() => Center(
                  child: Column(
                    children: [
                      Text(
                        'Connection Time',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          color: SColors.greenlight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CountDownTimer(
                          startTimer: _controller.vpnState.value ==
                              VpnEngine.vpnConnected),
                    ],
                  ),
                )),
          ),

          //location details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: Get.width,
              height: 80.0,
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: darkMode ? SColors.darkerGrey : SColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color of the shadow
                    spreadRadius: 1, // Spread radius
                    blurRadius: 2, // Blur radius
                    offset:
                        Offset(0, 1), // Offset in the direction of the shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  // country flag (leading)
                  Expanded(
                    child: connectedCountry(
                      title: _controller.vpn.value.countryLong.isEmpty
                          ? 'Select Country'
                          : _controller.vpn.value.countryLong,
                      icon: CircleAvatar(
                        radius: 30,
                        backgroundColor: SColors.greenlight,
                        child: _controller.vpn.value.countryLong.isEmpty
                            ? Icon(Icons.vpn_lock_rounded,
                                size: 30, color: Colors.white)
                            : null,
                        backgroundImage:
                            _controller.vpn.value.countryLong.isEmpty
                                ? null
                                : AssetImage(
                                    'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
                                  ),
                      ),
                    ),
                  ),
                  // ButtonWidget (trailing) => Get.to(() => NetworkTestScreen())
                  ButtonWidget(
                    onPressed: () {
                      Get.to(() => NetworkTestScreen());
                    },
                  ),
                ],
              ),
            ),
          ),

          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.1)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.3)),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: Colors.white,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          _controller.getButtonText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),

                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //connection status label
          Container(
            margin:
                EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: SColors.greenlight,
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.white,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ),
        ],
      );

  //bottom nav to change location
  Widget _changeLocation(BuildContext context, darkMode) => SafeArea(
          child: Semantics(
        button: true,
        child: InkWell(
          onTap: () => Get.to(() => LocationScreen()),
          child: Container(
              color: darkMode ? SColors.darkerGrey : SColors.greenlight,
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              height: 60,
              child: Row(
                children: [
                  //icon
                  // Icon(CupertinoIcons.globe, color: Colors.white, size: 28),
                  SvgPicture.asset(
                    "assets/images/globe.svg",
                    width: 60,
                    height: 60,
                  ),

                  //for adding some space
                  SizedBox(width: 10),

                  //text
                  Text(
                    'Change Location',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),

                  //for covering available spacing
                  Spacer(),

                  //icon
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.keyboard_arrow_right_rounded,
                        color: Colors.black, size: 26),
                  )
                ],
              ),),
        ),
      ));
}
