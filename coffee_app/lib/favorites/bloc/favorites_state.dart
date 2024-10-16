import 'package:flutter/foundation.dart';

@immutable
abstract class FavoritesState {
}

class FavoritesLoadedState implements FavoritesState {
  final List<Uint8List>? imageBytes;
  final String? imageRequestException;

  FavoritesLoadedState({required this.imageBytes, required this.imageRequestException});
}