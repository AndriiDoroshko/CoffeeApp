import 'dart:convert';
import 'package:coffee_app/providers/network_provider.dart';
import 'package:flutter/material.dart';

class ApiEndPoint {
  static String baseUrl = 'https://coffee.alexflipnote.dev';
  static String randomRoute = 'random.json';
}

abstract class ImageProvider {
  Future<Image> getImage();
}

class APIImageProvider implements ImageProvider {
  final networkProvider = NetworkApiService();

  @override
  Future<Image> getImage() async {
    try {
      final result = await networkProvider.getApi(
          ApiEndPoint.baseUrl, ApiEndPoint.randomRoute);
      final imageData = json.decode(result) as Map<String, dynamic>;
      final randomImageResponse = RandomImageResponse.fromJson(imageData);
      final imageBytes =
          await networkProvider.download(randomImageResponse.file.toString());
      final image = Image.memory(imageBytes);
      return image;
    } on Exception catch (e) {
      print('APIPortfolioProvider: $e');

      throw e.toString();
    }
  }
}

class RandomImageResponse {
  final Uri file;

  RandomImageResponse(this.file);

  RandomImageResponse.fromJson(Map<String, dynamic> json) : file = json['file'];

  Map<String, dynamic> toJson() => {'file': file};
}
