import 'package:flutter/material.dart';

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // print("UN POP");
    // print("PREV: ${previousRoute?.settings.name}");
    // print("NEXT: ${route.settings.name}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // print("UN REMOVE");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // print("UN REPLACE");
  }
}
