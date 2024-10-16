import 'dart:typed_data';

class DownloadedImage {
  final Uint8List? imageBytes;
  final bool isSaved;

  DownloadedImage({required this.imageBytes, required this.isSaved});
}