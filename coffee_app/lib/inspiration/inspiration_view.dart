import 'package:coffee_app/inspiration/bloc/inspiration_bloc.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_event.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_state.dart';
import 'package:coffee_app/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspirationView extends StatelessWidget {
  const InspirationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InspirationBloc>.value(
      value: InspirationBloc(APIImageProvider()),
      child: BlocConsumer<InspirationBloc, InspirationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("")
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<InspirationBloc>()
                            .add(InspirationRefreshEvent());
                      },
                      child: const Text('Add to Favorites'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Load New Image'),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
