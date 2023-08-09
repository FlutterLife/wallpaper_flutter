import 'dart:math';

import 'package:blacky/AmoledImage.dart';
import 'package:blacky/AmoledImage2.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import 'commen.dart';

ScrollController listScrollController = ScrollController();

Random random = Random();

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int currentIndex = 0;

  selectedIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // disableCapture();
    // MyApp().deleteCacheDir();
    // MyApp().deleteAppDir();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Appcolor.bgColor,
      body: Stack(children: [
        if (currentIndex == 0)
          WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const AmoledImage())
        else if (currentIndex == 1)
          WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const AmoledImage2()),
        Align(alignment: Alignment.bottomCenter, child: bottomNavBar()),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.03, bottom: Get.height * 0.18),
              child: Bounce(
                duration: const Duration(milliseconds: 300),
                onPressed: () {
                  setState(() {
                    listScrollController.animateTo(
                      listScrollController.position.minScrollExtent,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                  });
                },
                child: Image.asset(
                  'assets/upsaid.png',
                  height: Get.height * 0.08,
                ),
              )),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.03, bottom: Get.height * 0.09),
              child: Bounce(
                duration: const Duration(milliseconds: 300),
                onPressed: () {
                  setState(() {
                    listScrollController.animateTo(
                      listScrollController.position.maxScrollExtent,
                      curve: Curves.bounceOut,
                      duration: const Duration(seconds: 300),
                    );
                  });
                },
                child: Image.asset(
                  'assets/downsaid.png',
                  height: Get.height * 0.08,
                ),
              )),
        ),
      ]),
    );
  }

  Widget bottomNavBar() {
    return Container(
      height: Get.height * 0.08,
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomNavBarIcon(name: 'Amoled', index: 0, pageInd: 0),
          bottomNavBarIcon(name: 'Wallpaper', index: 1, pageInd: 1),
        ],
      ),
    );
  }

  Widget bottomNavBarIcon({name, ontap, index, pageInd}) {
    return Bounce(
      onPressed: () {
        setState(() {
          selectedIndex(index);
          pageInd = currentIndex;
        });
      },
      duration: const Duration(milliseconds: 200),
      child: Container(
          padding: const EdgeInsets.all(5),
          height: Get.height * 0.04,
          width: Get.width * 0.5,
          child: Text(
            name,
            style: TextStyle(
                color: currentIndex == pageInd ? Colors.white : Colors.grey,
                fontSize: Get.height * 0.018),
            textAlign: TextAlign.center,
          )),
    );
  }
}
