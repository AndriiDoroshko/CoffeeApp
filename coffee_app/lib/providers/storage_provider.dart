import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

abstract class BaseStorageProviderService {
  Future<bool> saveImageLocally(Uint8List imageData);
}

class StorageService implements BaseStorageProviderService {
  String globalFileName = 'saved_images.bin';

  @override
  Future<bool> saveImageLocally(Uint8List imageData) async {
    try {
      final Directory directory = Directory.systemTemp;
      final File file = File('${directory.path}/$globalFileName');

      if (!(await file.exists())) {
        await file.create();
      }

      final RandomAccessFile raf = await file.open(mode: FileMode.append);

      final Uint8List delimiter = Uint8List.fromList('---IMAGE---'.codeUnits);

      await raf.writeFrom(delimiter);
      await raf.writeFrom(imageData);
      await raf.close();
      return true;
    } catch (e) {
      return Future.error('Failed to save image: $e');
    }
  }

  Future<bool> deleteImage(Uint8List imageData) async {
    try {
      final List<Uint8List> images = await loadAllImages();
      final Directory directory = Directory.systemTemp;
      final File file = File('${directory.path}/$globalFileName');

      // Remove the image from the list if it matches
      final filteredImages =
          images.where((image) => !image.equals(imageData)).toList();

      // Clear the file content
      await file.writeAsBytes([]);
      final RandomAccessFile raf = await file.open(mode: FileMode.append);

      for (var image in filteredImages) {
        await raf.writeString('---IMAGE---');
        await raf.writeFrom(image);
      }

      await raf.close();
      return true;
    } catch (e) {
      return Future.error('Failed to delete image: $e');
    }
  }

  Future<bool> doesImageExist(Uint8List imageData) async {
    try {
      final List<Uint8List> images = await loadAllImages();

      for (var image in images) {
        if (image.equals(imageData)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return Future.error('Failed to check if image exists: $e');
    }
  }

  Future<List<Uint8List>> loadAllImages() async {
    try {
      final Directory directory = Directory.systemTemp;
      final File file = File('${directory.path}/$globalFileName');

      if (!(await file.exists())) {
        return [];
      }

      final Uint8List fileContent = await file.readAsBytes();
      final Uint8List delimiter = Uint8List.fromList('---IMAGE---'.codeUnits);

      final List<Uint8List> images = [];
      int start = 0;
      int end = _indexOf(fileContent, delimiter, start); // Loop through fileData to find and extract all images

      while (end != -1) {
        if (start != end) {
          images.add(fileContent.sublist(start, end));
        }

        start = end + delimiter.length; // Move the start index past the delimiter
        end = _indexOf(fileContent, delimiter, start); // Find the next delimiter
      }

      // Capture any remaining data after the last delimiter
      if (start < fileContent.length) {
        images.add(fileContent.sublist(start));
      }
      return images;
    } catch (e) {
      return Future.error('Failed to load images: $e');
    }
  }

  int _indexOf(Uint8List data, Uint8List pattern, int start) {
    for (int i = start; i <= data.length - pattern.length; i++) {
      bool found = true;
      for (int j = 0; j < pattern.length; j++) {
        if (data[i + j] != pattern[j]) {
          found = false;
          break;
        }
      }
      if (found) {
        return i;
      }
    }
    return -1;
  }
}

// Extension method to compare Uint8List
extension Uint8ListEquality on Uint8List {
  bool equals(Uint8List other) {
    if (length != other.length) return false;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
