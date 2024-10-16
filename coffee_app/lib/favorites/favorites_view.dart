import 'package:coffee_app/favorites/bloc/favorites_bloc.dart';
import 'package:coffee_app/favorites/bloc/favorites_event.dart';
import 'package:coffee_app/favorites/bloc/favorites_state.dart';
import 'package:coffee_app/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>.value(
        value: FavoritesBloc(APIImageProvider()),
        child: BlocConsumer<FavoritesBloc, FavoritesState>(
            listener: (context, state) {},
            builder: (context, state) {
              final bloc = context.read<FavoritesBloc>();
              var imageList = [];
              if (state is FavoritesLoadedState) {
                imageList = state.imageBytes ?? [];
                if ((state.imageBytes == null) && (state.imageRequestException == null)) {
                  bloc.add(FavoritesFetchEvent());
                }
              }

              return Scaffold(
                body: imageList.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          crossAxisSpacing: 4.0, // Spacing between grid items horizontally
                          mainAxisSpacing: 4.0, // Spacing between grid items vertically
                        ),
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.memory(
                            imageList[index],
                            fit: BoxFit.cover, // Ensures image covers the grid tile
                          );
                        },
                      )
                    : const Center(child: Text('No images to display')),
              );
            }));
  }
}
