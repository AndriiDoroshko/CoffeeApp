
import 'package:bloc/bloc.dart';
import 'package:coffee_app/favorites/bloc/favorites_event.dart';
import 'package:coffee_app/favorites/bloc/favorites_state.dart';
import 'package:coffee_app/providers/image_provider.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
    FavoritesBloc(ImageProvider imageProvider)
      : super(FavoritesLoadedState(imageBytes: null, imageRequestException: null)) {

    on<FavoritesFetchEvent>((event, emit) async {

       try {
        final deletedImage = await imageProvider.getAllImages();
        
        emit(FavoritesLoadedState(imageBytes: deletedImage, imageRequestException: null));
      } catch (e) {
        emit(FavoritesLoadedState(imageBytes: [], imageRequestException: e.toString()));
      }
    });
}}