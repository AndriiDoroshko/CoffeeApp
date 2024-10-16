import 'dart:convert';
import 'dart:typed_data';
import 'package:coffee_app/providers/network_provider.dart';
import 'package:coffee_app/providers/storage_provider.dart';
import 'package:flutter/material.dart';

class ApiEndPoint {
  static String randomCoffeeUrl = 'https://coffee.alexflipnote.dev/random.json';
}

abstract class ImageProvider {
  Future<Uint8List> getImage();
  Future<bool> saveImage(Uint8List imageBytes);
}

class APIImageProvider implements ImageProvider {
  final networkProvider = NetworkApiService();
  final storageService = StorageService();

  @override
  Future<Uint8List> getImage() async {
    try {
      final result = await networkProvider.getApi(ApiEndPoint.randomCoffeeUrl);
      final imageData = json.decode(result) as Map<String, dynamic>;
      final randomImageResponse = RandomImageResponse.fromJson(imageData);
      final imageBytes = await networkProvider.download(randomImageResponse.file);

      return imageBytes;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> saveImage(Uint8List imageBytes) async {
    try {
      final isSaved = await storageService.saveImageLocally(imageBytes);
      if (isSaved) {
        return isSaved;
      }
      return Future.error('Can not save this image. Try again later');  
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
