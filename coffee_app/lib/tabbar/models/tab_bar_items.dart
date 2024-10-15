import 'package:flutter/material.dart';

enum TabBarItems {
  add, favorites
}

extension TabBarItemsExtension on TabBarItems {
  String get title {
    switch (this) {
      case TabBarItems.add:
        return 'Add';
      case TabBarItems.favorites:
      return 'Favorites';
    }
  }

  IconData get icon {
    switch (this) {
      case TabBarItems.add:
        return Icons.add_a_photo_outlined;
      case TabBarItems.favorites:
        return Icons.star_border;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case TabBarItems.add:
        return Icons.add_a_photo_rounded;
      case TabBarItems.favorites:
        return Icons.star_border_outlined;
    }
  }
}
