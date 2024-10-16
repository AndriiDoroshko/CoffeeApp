import 'package:flutter/foundation.dart' show Uint8List, immutable;

@immutable
abstract class InspirationEvent {
}

class InspirationRefreshEvent implements InspirationEvent {
  
}

class InspirationLoadedEvent implements InspirationEvent {

}

class InspirationSaveImageEvent implements InspirationEvent {
  final Uint8List imageBytes;

  InspirationSaveImageEvent({required this.imageBytes});
}