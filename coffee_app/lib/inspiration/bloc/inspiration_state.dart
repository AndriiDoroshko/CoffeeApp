import 'package:flutter/material.dart';

@immutable
abstract class InspirationState {
}

class InspirationLoadingState implements InspirationState {
  
}

class InspirationLoadedState implements InspirationState {
  final Image? image;
  final Exception? imageRequestException;

  InspirationLoadedState({required this.image, required this.imageRequestException});
}
