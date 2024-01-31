import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/helpers/helper_func.dart';

import '../controllers/location_controller.dart';

import '../helpers/SColors.dart';
import '../main.dart';
import '../widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _controller = LocationController();

  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) _controller.getVpnData();
    final darkMode = SHelperFunctions.isDarkMode(context);

    // _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Obx(
      () => Scaffold(
        //app bar
        appBar: AppBar(
          title: Text(
            'Servers (${_controller.vpnList.length})',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30,
            ),
          ),
        ),


        //refresh button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
            onPressed: () => _controller.getVpnData(),
            child: Icon(Iconsax.refresh, color: SColors.white,),
            backgroundColor: darkMode ? SColors.darkerGrey : SColors.black,
          ),
        ),

        body: _controller.isLoading.value
            ? _loadingWidget()
            : _controller.vpnList.isEmpty
                ? _noVPNFound()
                : _vpnData(),
      ),
    );
  }

  _vpnData() => ListView.builder(
      itemCount: _controller.vpnList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          top: mq.height * .015,
          bottom: mq.height * .1,
          left: mq.width * .04,
          right: mq.width * .04),
      itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnList[i]));

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            LottieBuilder.asset('assets/lottie/loading.json',
                width: mq.width * .7),

            //text
            Text(
              'Loading Server...',
              style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          'Server Not Found!',
          style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
      );
}
