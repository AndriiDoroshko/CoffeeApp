import 'package:coffee_app/tabbar/models/tab_bar_items.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class TabBarState {
  final int lastSelectedIndex;
  const TabBarState(this.lastSelectedIndex);
}

class TabBarStateSwitched implements TabBarState {
  final TabBarItems selectedItem;
  @override
  final int lastSelectedIndex;
  const TabBarStateSwitched(this.selectedItem, this.lastSelectedIndex);
}
