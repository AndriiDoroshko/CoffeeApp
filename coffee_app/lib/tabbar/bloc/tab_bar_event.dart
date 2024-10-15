import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class TabBarEvent {
  const TabBarEvent();
}

class TabBarSwitchEvent implements TabBarEvent {
  final int indexOfSelected;
  const TabBarSwitchEvent(this.indexOfSelected);
}

class TabBarSetDeafultStateEvent implements TabBarEvent {
  const TabBarSetDeafultStateEvent();
}
