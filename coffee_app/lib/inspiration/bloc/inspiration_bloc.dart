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
        imageProvider.saveImage(imageBytes);
        emit(InspirationLoadedState(
            imageBytes: imageBytes, imageRequestException: null, imageSaved: true));
      } catch (e) {
        emit(InspirationLoadedState(
            imageBytes: null, imageRequestException: e.toString(), imageSaved: false));
      }
    });

    on<InspirationRefreshEvent>((event, emit) async {
      try {
        emit(InspirationLoadingState());
        final imageBytes = await imageProvider.getImage();
        emit(InspirationLoadedState(
            imageBytes: imageBytes, imageRequestException: null, imageSaved: false));
      } catch (e) {
        emit(InspirationLoadedState(
            imageBytes: null, imageRequestException: e.toString(), imageSaved: false));
      }
    });
  }
}
