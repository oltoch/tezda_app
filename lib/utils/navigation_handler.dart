import 'dart:async';

import 'package:flutter/material.dart';

/// Handles navigation
abstract class NavigationHandler {
  ///Pushes [destinationRoute] route onto the stack
  Future<T?>? pushNamed<T extends Object?>(
    String destinationRoute, {
    Object? arg,
  });

  ///Pushes [destinationRoute] onto stack and removes stack items until
  ///[lastRoute] is hit
  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String destinationRoute, {
    bool Function(Route<dynamic>)? predicate,
    Object arg,
  });

  ///Pops current route off stack
  void pop<T extends Object?>([T? result]);

  late final GlobalKey<NavigatorState> navigatorKey;
}

class NavigationHandlerImpl implements NavigationHandler {
  @override
  late final GlobalKey<NavigatorState> navigatorKey;

  /// Constructs a NavigationHandler instance
  NavigationHandlerImpl({GlobalKey<NavigatorState>? navigatorKey}) {
    this.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
  }

  NavigatorState? get state => navigatorKey.currentState;

  @override
  void pop<T extends Object?>([T? result]) {
    if (state != null) {
      return state!.pop(result);
    }
  }

  @override
  Future<T?>? pushNamed<T extends Object?>(String destinationRoute,
      {Object? arg}) {
    if (state != null) {
      return state!.pushNamed(destinationRoute, arguments: arg);
    }
    return null;
  }

  @override
  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
      String destinationRoute,
      {bool Function(Route<dynamic>)? predicate,
      Object? arg}) {
    if (state != null) {
      return state!.pushNamedAndRemoveUntil(
        destinationRoute,
        predicate ?? (route) => false,
        arguments: arg,
      );
    }
    return null;
  }
}
