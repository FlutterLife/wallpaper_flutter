import 'dart:convert';
import 'dart:math';

import 'package:blacky/bottomnavbarview.dart';
import 'package:blacky/commen.dart';
import 'package:blacky/main.dart';
import 'package:blacky/model/blackmodel.dart';
import 'package:blacky/setaswallpaper.dart';
import 'package:blacky/shimmer/shimmer.dart';
import 'package:blacky/splashscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;


import 'ad_helper.dart';

int? currentSelectedBusiness;

class AmoledImage extends StatefulWidget {
  const AmoledImage({super.key});

  @override
  State<AmoledImage> createState() => _AmoledImageState();
}

class _AmoledImageState extends State<AmoledImage> {
  /// Load an AppOpenAd.
  AppOpenAd? myAppOpenAd;

  /// Load an AppOpenAd.
  loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: AdHelper.appOpenAdUnitId, //Your ad Id from admob
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              myAppOpenAd = ad;
              myAppOpenAd!.show();
            },
            onAdFailedToLoad: (error) {}),
        orientation: AppOpenAd.orientationPortrait);
  }

  @override
  void initState() {
    super.initState();
    // loadAppOpenAd();
    // MyApp().deleteCacheDir();
    // MyApp().deleteAppDir();
    // disableCapture();
  }

  Future refresh() async {
    setState(() {
      SplasScreen().blacky();
    });
  }

  String? res;
  bool _isDisable = true;
  bool downloading = false;
  Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      backgroundColor: Colors.black,
      color: Colors.white,
      child: FutureBuilder<List<BlackImage>>(
        future: const SplasScreen().blacky(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
                controller: listScrollController,
                padding: EdgeInsets.only(
                  left: Get.width * 0.025,
                  right: Get.width * 0.025,
                  top: Get.height * 0.06,
                  bottom: Get.height * 0.08,
                ),
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var urlImage = snapshot.data![index];

                  // snapshot.data!.length = random.nextInt(snapshot.data!.length);

                  return Bounce(
                    duration: const Duration(milliseconds: 500),
                    onPressed: () {
                      Get.to(const SetAsWallpaper(),
                          arguments: [urlImage.image]);
                    },
                    child: Container(
                        height: index.isEven ? 1.4 : 1.5,
                        width: index.isEven ? 1.4 : 1.5,
                        decoration: BoxDecoration(
                            color: const Color(0xff2C2F33),
                            borderRadius: BorderRadius.circular(15)),
                        child: CachedNetworkImage(
                            imageUrl: urlImage.image,
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 10, color: Colors.white10)
                                    ],
                                    borderRadius: BorderRadius.circular(15),
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
                                  height: index.isEven ? 1.4 : 1.5,
                                  width: index.isEven ? 1.4 : 1.5,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.white10)
                                      ],
                                      color: const Color(0xff2C2F33),
                                      borderRadius: BorderRadius.circular(15)),
                                )),
                            errorWidget: (context, url, error) => Container(
                                  height: index.isEven ? 1.4 : 1.5,
                                  width: index.isEven ? 1.4 : 1.5,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage("assets/logo.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.white10)
                                      ],
                                      color: const Color(0xff2C2F33),
                                      borderRadius: BorderRadius.circular(15)),
                                ))),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.4 : 1.5);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          return Center(
            child: Animate(
              effects: const [
                FadeEffect(begin: 3, end: 1, duration: Duration(seconds: 2)),
                ScaleEffect(
                  curve: Curves.bounceIn,
                )
              ],
              child: Image.asset(
                "assets/logo.png",
                height: Get.height * 0.2,
              ),
            ),
          );
        },
      ),
    );
  }
}
