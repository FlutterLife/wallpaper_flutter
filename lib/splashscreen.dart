import 'dart:async';
import 'dart:convert';

import 'package:blacky/bottomnavbarview.dart';
import 'package:blacky/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'commen.dart';
import 'model/blackmodel.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
  Future<List<BlackImage>> blacky() async {
    final response = await http.get(Uri.parse(ApiUrl.pageApi1));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((user) => BlackImage.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<BlackImage>> blacky2() async {
    final response = await http.get(Uri.parse(ApiUrl.pageApi2));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse.map((user) => BlackImage.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    super.initState();
        Timer(const Duration(seconds: 3), () async {
      Get.off(const BottomNavBarView());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(color: Appcolor.bgColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Animate(
              effects: const [
                FadeEffect(begin: 1, end: 3, duration: Duration(seconds: 1)),
                ScaleEffect(
                  curve: Curves.easeInSine,
                )
              ],
              child: Image.asset(
                "assets/logo.png",
                height: Get.height * 0.2,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
