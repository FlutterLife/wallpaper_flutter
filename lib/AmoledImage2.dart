import 'dart:convert';

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

class AmoledImage2 extends StatefulWidget {
  const AmoledImage2({super.key});

  @override
  State<AmoledImage2> createState() => _AmoledImage2State();
}

class _AmoledImage2State extends State<AmoledImage2> {
  @override
  void initState() {
    super.initState();
  }

  Future refresh() async {
    setState(() {
      // SplasScreen().blacky();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      backgroundColor: Colors.black,
      color: Colors.white,
      child: FutureBuilder<List<BlackImage>>(
        future: const SplasScreen().blacky2(),
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
                  return Bounce(
                    duration: const Duration(milliseconds: 300),
                    onPressed: () {
                      Get.to(const SetAsWallpaper(),
                          arguments: [snapshot.data![index].image]);
                    },
                    child: Container(
                        height: index.isEven ? 1.4 : 1.5,
                        width: index.isEven ? 1.4 : 1.5,
                        decoration: BoxDecoration(
                            color: const Color(0xff2C2F33),
                            borderRadius: BorderRadius.circular(15)),
                        child: CachedNetworkImage(
                            imageUrl: snapshot.data![index].image,
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
            return Text('${snapshot.error}');
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
