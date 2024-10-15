import 'dart:convert';
import 'package:coffee_app/providers/network_provider.dart';
import 'package:flutter/material.dart';

class ApiEndPoint {
  static String randomCoffeeUrl = 'https://coffee.alexflipnote.dev/random.json';
}

abstract class ImageProvider {
  Future<Image> getImage();
}

class APIImageProvider implements ImageProvider {
  final networkProvider = NetworkApiService();

  @override
  Future<Image> getImage() async {
    try {
      final result = await networkProvider.getApi(ApiEndPoint.randomCoffeeUrl);
      final imageData = json.decode(result) as Map<String, dynamic>;
      final randomImageResponse = RandomImageResponse.fromJson(imageData);
      final imageBytes = await networkProvider.download(randomImageResponse.file);

      final image = Image.memory(imageBytes);
      return image;
    } catch (e) {
      return Future.error(e);
    }
  }
}

class RandomImageResponse {
  final String file;

  RandomImageResponse(this.file);

  RandomImageResponse.fromJson(Map<String, dynamic> json) : file = json['file'];

  Map<String, dynamic> toJson() => {'file': file};
}
