import 'package:bloc/bloc.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_event.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_state.dart';
import 'package:coffee_app/providers/image_provider.dart';

class InspirationBloc extends Bloc<InspirationEvent, InspirationState> {
  InspirationBloc(ImageProvider imageProvider) : super( InspirationLoadedState(image: null, imageRequestException: null)) {
    on<InspirationLoadedEvent>((event, emit) async {

      emit(InspirationLoadedState(image: null, imageRequestException: null));
    });

    on<InspirationRefreshEvent>((event, emit) async {
      imageProvider.getImage();
      
      try {
        emit(InspirationLoadingState());
        final image = await imageProvider.getImage();
        emit(InspirationLoadedState(image: image, imageRequestException: null));
      } on Exception catch (e) {
        emit(InspirationLoadedState(image: null, imageRequestException: e));
      }
    });
  }
}

