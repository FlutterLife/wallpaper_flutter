// To parse this JSON data, do
//
//     final blackImage = blackImageFromJson(jsonString);

import 'dart:convert';

List<BlackImage> blackImageFromJson(String str) =>
    List<BlackImage>.from(json.decode(str).map((x) => BlackImage.fromJson(x)));

String blackImageToJson(List<BlackImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlackImage {
  String image;

  BlackImage({
    required this.image,
  });

  factory BlackImage.fromJson(Map<String, dynamic> json) => BlackImage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
