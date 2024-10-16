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

      await raf.writeString('---IMAGE---');
      await raf.writeFrom(imageData);
      await raf.close();
      return true;
    } catch (e) {
      return Future.error('Failed to save image: $e');
    }
  }
}
