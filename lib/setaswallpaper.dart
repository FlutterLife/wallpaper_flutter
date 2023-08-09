import 'dart:ui';

import 'package:blacky/commen.dart';

import 'package:blacky/shimmer/shimmer.dart';
import 'package:blacky/wallpaper_manager_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SetAsWallpaper extends StatefulWidget {
  const SetAsWallpaper({super.key});

  @override
  State<SetAsWallpaper> createState() => _SetAsWallpaperState();
}

class _SetAsWallpaperState extends State<SetAsWallpaper> {
  @override
  void initState() {
    super.initState();
    // dowloadImage(context);
  }

  Future<void> _setwallpaper(location) async {
    var file = await DefaultCacheManager().getSingleFile(data[0]);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wallpaper updated'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Setting Wallpaper'),
        ),
      );
      print(e);
    }
  }

  String? res;
  bool _isDisable = true;
  bool downloading = false;
  Stream<String>? progressString;

  // Future<void> dowloadImage(BuildContext context) async {
  //   progressString = Wallpaper.imageDownloadProgress(data[0]);
  //   progressString!.listen((data) {
  //     setState(() {
  //       res = data;
  //       downloading = true;
  //     });
  //     print("DataReceived: " + data);
  //   }, onDone: () async {
  //     setState(() {
  //       downloading = false;
  //       _isDisable = false;
  //     });
  //     print("Task Done");
  //   }, onError: (error) {
  //     setState(() {
  //       downloading = false;
  //       _isDisable = true;
  //     });
  //     print("Some Error");
  //   });
  // }

  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";
  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // disableCapture();
    var wallpaper = data[0];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            downloading ? imageDownloadDialog() : wallImage(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Bounce(
                      duration: const Duration(milliseconds: 300),
                      onPressed: ()  {
                        // await dowloadImage(context);

                        // home = await
                        // Wallpaper.homeScreen(
                        //   options: RequestSizeOptions.RESIZE_FIT,
                        // );
                        // setState(() {
                        //   home = home;
                        // });
                        _setwallpaper(WallpaperManagerFlutter.HOME_SCREEN);
                        showTostMessage("Home Screen Done");
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                            color: const Color(0xff2C2F33),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Home Screen',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 300),
                      onPressed: ()  {
                        // await dowloadImage(context);

                        // lock = await
                        // Wallpaper.lockScreen(
                        //   options: RequestSizeOptions.RESIZE_FIT,
                        // );
                        // setState(() {
                        //   lock = lock;
                        // });
                        _setwallpaper(WallpaperManagerFlutter.LOCK_SCREEN);
                        showTostMessage("LockScreen Done");
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                            color: const Color(0xff2C2F33),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Lock Screen',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 300),
                      onPressed: ()  {
                        // await dowloadImage(context);

                        // both = await
                        // Wallpaper.bothScreen(
                        //   options: RequestSizeOptions.RESIZE_FIT,
                        // );
                        // setState(() {
                        //   both = both;
                        // });
                        _setwallpaper(WallpaperManagerFlutter.BOTH_SCREENS);
                        showTostMessage("BothScreen Done");
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                            color: const Color(0xff2C2F33),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Both Screens',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Bounce(
                  duration: const Duration(milliseconds: 300),
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Get.height * 0.01, left: Get.width * 0.05),
                    height: Get.height * 0.06,
                    width: Get.height * 0.06,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/back.png'),
                    )),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageDownloadDialog() {
    return Stack(
      children: [
        wallImage(),
        Center(
          child: SizedBox(
            height: 120.0,
            width: 200.0,
            child: Card(
              color: Appcolor.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Set File : $res",
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget wallImage() {
    return Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: const Color(0xff2C2F33),
            borderRadius: BorderRadius.circular(15)),
        child: CachedNetworkImage(
            imageUrl: data[0],
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.white10)
                    ],
                    // borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Appcolor.bgColor,
                highlightColor: Colors.white54,
                enabled: true,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(blurRadius: 5, color: Colors.white10)
                      ],
                      color: const Color(0xff2C2F33),
                      borderRadius: BorderRadius.circular(15)),
                )),
            errorWidget: (context, url, error) => Container(
                  padding: const EdgeInsets.all(20),
                  height: Get.height * 0.85,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(blurRadius: 5, color: Colors.white10)
                      ],
                      color: const Color(0xff2C2F33),
                      borderRadius: BorderRadius.circular(15)),
                )));
  }
}
