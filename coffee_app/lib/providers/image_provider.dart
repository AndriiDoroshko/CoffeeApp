import 'dart:convert';
import 'dart:typed_data';
import 'package:coffee_app/models/downloaded_image.dart';
import 'package:coffee_app/models/random_image_response.dart';
import 'package:coffee_app/providers/network_provider.dart';
import 'package:coffee_app/providers/storage_provider.dart';

class ApiEndPoint {
  static String randomCoffeeUrl = 'https://coffee.alexflipnote.dev/random.json';
}

abstract class ImageProvider {
  Future<DownloadedImage> getImage();
  Future<DownloadedImage> saveImage(Uint8List imageBytes);
  Future<DownloadedImage> deleteImage(Uint8List imageBytes);
  Future<List<Uint8List>> getAllImages();
}

class APIImageProvider implements ImageProvider {
  final networkProvider = NetworkApiService();
  final storageProvider = StorageService();

  @override
  Future<DownloadedImage> getImage() async {
    try {
      final result = await networkProvider.getApi(ApiEndPoint.randomCoffeeUrl);
      final imageData = json.decode(result) as Map<String, dynamic>;
      final randomImageResponse = RandomImageResponse.fromJson(imageData);
      final imageBytes = await networkProvider.download(randomImageResponse.file);
      final isSaved = await storageProvider.doesImageExist(imageBytes);

      return DownloadedImage(imageBytes: imageBytes, isSaved: isSaved);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<DownloadedImage> saveImage(Uint8List imageBytes) async {
    try {
      final isSaved = await storageProvider.saveImageLocally(imageBytes);
      if (isSaved) {
        return DownloadedImage(imageBytes: imageBytes, isSaved: isSaved);
      }
      return Future.error('Can not save this image. Try again later');  
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<DownloadedImage> deleteImage(Uint8List imageBytes) async {
    try {
      final isDeleted = await storageProvider.deleteImage(imageBytes);
      if (isDeleted) {
        return DownloadedImage(imageBytes: imageBytes, isSaved: !isDeleted);
      }
      return Future.error('Can not delete this image. Try again later');  
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Uint8List>> getAllImages() async {
    try {
      final images = await storageProvider.loadAllImages();

      return images;
    } catch (e) {
      return Future.error(e);
    }
  }
}
