import 'package:coffee_app/inspiration/bloc/inspiration_bloc.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_event.dart';
import 'package:coffee_app/inspiration/bloc/inspiration_state.dart';
import 'package:coffee_app/providers/image_provider.dart';
import 'package:coffee_app/utilities/show_error_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspirationView extends StatelessWidget {
  const InspirationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InspirationBloc>.value(
      value: InspirationBloc(APIImageProvider()),
      child: BlocConsumer<InspirationBloc, InspirationState>(
          listener: (context, state) {
        if (state is InspirationLoadedState) {
          if (state.imageRequestException != null) {
            showErrorDialog(context, state.imageRequestException ?? "Unknown error");
          }
        }
      }, builder: (context, state) {
        final bloc = context.read<InspirationBloc>();

        var image = const SizedBox(
          width: 44,
          height: 44,
          child: CircularProgressIndicator(), // Loading indicator
        );

        if (state is InspirationLoadedState) {
          if (state.image != null) {
            image = SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: state.image ?? const Icon(Icons.image),
            );
          } else if (state.imageRequestException != null) {
            image = SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: const Icon(Icons.image));
          } else {
            bloc.add(InspirationRefreshEvent());
          }
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                image, // Downloaded Image or Progress Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<InspirationBloc>()
                            .add(InspirationRefreshEvent());
                      },
                      child: const Text('Load New'),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
