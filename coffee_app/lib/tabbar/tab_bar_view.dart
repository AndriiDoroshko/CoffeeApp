import 'package:coffee_app/tabbar/bloc/tab_bar_bloc.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_event.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_state.dart';
import 'package:coffee_app/tabbar/models/tab_bar_items.dart';
import 'package:coffee_app/tabbar/tab_bar_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTabBarView extends StatelessWidget {

  const MyTabBarView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>.value(
      value: TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {
        
       },
       builder: (context, state) {

        final bloc = context.read<TabBarBloc>();

        return Scaffold(
          appBar: AppBar(
              title: const Text('Your Coffee Inspo'),
          ),
          body: const TabBarContentView(),
          bottomNavigationBar: BottomNavigationBar(
              items: bloc.tabBarItems
                  .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.title,
                      activeIcon: Icon(e.activeIcon)))
                  .toList(),
              onTap: (index) =>
                  { context.read<TabBarBloc>().add(TabBarSwitchEvent(index)) },
              currentIndex: state.lastSelectedIndex,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered),
        );
      }),
    );
  }
}
