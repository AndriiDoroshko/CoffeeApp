import 'package:flutter/foundation.dart' show Uint8List, immutable;

@immutable
abstract class InspirationState {
}

class InspirationLoadingState implements InspirationState {
}

class InspirationLoadedState implements InspirationState {
  final Uint8List? imageBytes;
  final String? imageRequestException;
  final bool imageSaved;

  InspirationLoadedState({required this.imageBytes, required this.imageRequestException, required this.imageSaved});
}
