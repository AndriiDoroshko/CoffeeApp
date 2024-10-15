import 'package:coffee_app/inspiration/inspiration_view.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_bloc.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_state.dart';
import 'package:coffee_app/tabbar/models/tab_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarContentView extends StatelessWidget {

  const TabBarContentView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        builder: (context, state) {

          final tabBarState = state as TabBarStateSwitched;

          switch (tabBarState.selectedItem) {
            case TabBarItems.add:
              return const InspirationView();
            case TabBarItems.favorites:
             return Scaffold(
                body: Container(
              color: Colors.blue,
              ));
          }
        });
  }
}
