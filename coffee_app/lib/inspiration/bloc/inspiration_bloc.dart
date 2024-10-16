import 'package:bloc/bloc.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_event.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_state.dart';
import 'package:coffee_app/providers/image_provider.dart';

class InspirationBloc extends Bloc<InspirationEvent, InspirationState> {
  InspirationBloc(ImageProvider imageProvider)
      : super(InspirationLoadedState(
            imageBytes: null, imageRequestException: null, imageSaved: false)) {
    on<InspirationLoadedEvent>((event, emit) async {
      emit(InspirationLoadedState(
          imageBytes: null, imageRequestException: null, imageSaved: false));
    });

    on<InspirationSaveImageEvent>((event, emit) async {
      try {
        final imageBytes = event.imageBytes;
        final deletedImage = await imageProvider.saveImage(imageBytes);
        emit(InspirationLoadedState(
            imageBytes: deletedImage.imageBytes,
            imageRequestException: null,
            imageSaved: deletedImage.isSaved));
      } catch (e) {
        emit(InspirationLoadedState(
            imageBytes: null, imageRequestException: e.toString(), imageSaved: false));
      }
    });

    on<InspirationDeleteImageEvent>((event, emit) async {
      try {
        final imageBytes = event.imageBytes;
        final deletedImage = await imageProvider.deleteImage(imageBytes);

        emit(InspirationLoadedState(
            imageBytes: deletedImage.imageBytes,
            imageRequestException: null,
            imageSaved: deletedImage.isSaved));
      } catch (e) {
        emit(InspirationLoadedState(
            imageBytes: null, imageRequestException: e.toString(), imageSaved: false));
      }
    });

    on<InspirationRefreshEvent>((event, emit) async {
      try {
        emit(InspirationLoadingState());
        final downloadedImage = await imageProvider.getImage();
        emit(InspirationLoadedState(
            imageBytes: downloadedImage.imageBytes,
            imageRequestException: null, 
            imageSaved: downloadedImage.isSaved));
      } catch (e) {
        emit(InspirationLoadedState(
            imageBytes: null, 
            imageRequestException: e.toString(), 
            imageSaved: false));
      }
    });
  }
}
