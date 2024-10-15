import 'package:bloc/bloc.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_event.dart';
import 'package:coffee_app/tabbar/bloc/tab_bar_state.dart';
import 'package:coffee_app/tabbar/models/tab_bar_items.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  final List<TabBarItems> tabBarItems = [
    TabBarItems.add,
    TabBarItems.favorites
  ];

  TabBarBloc() : super(const TabBarStateSwitched(TabBarItems.add, 0)) {
    on<TabBarSwitchEvent>((event, emit) async {
      final index = event.indexOfSelected;
      final elementAtIndex = tabBarItems.elementAt(index);
      emit(TabBarStateSwitched(elementAtIndex, index));
    });

    on<TabBarSetDeafultStateEvent>((event, emit) async {
      emit(const TabBarStateSwitched(TabBarItems.add, 0));
    });
  }
}

