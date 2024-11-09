import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tezda_app/models/product_model.dart';
import 'package:tezda_app/modules/onboarding/views/login_view.dart';
import 'package:tezda_app/modules/onboarding/views/register_view.dart';
import 'package:tezda_app/modules/product/views/product_details_view.dart';
import 'package:tezda_app/modules/product/views/product_list_view.dart';
import 'package:tezda_app/modules/profile/views/profile_view.dart';

Route? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.route:
      return _getPageTransition(
        settings: settings,
        child: const LoginView(),
      );
    case RegisterView.route:
      return _getPageTransition(
        settings: settings,
        child: const RegisterView(),
      );
    case ProductListView.route:
      return _getPageTransition(
        settings: settings,
        child: const ProductListView(),
      );
    case ProductDetailsView.route:
      return _getPageTransition(
        settings: settings,
        child: ProductDetailsView(
          product: settings.arguments as Product,
        ),
      );
    case ProfileView.route:
      return _getPageTransition(
        settings: settings,
        child: const ProfileView(),
      );
    default:
      return null;
  }
}

_getPageTransition({
  required RouteSettings settings,
  required Widget child,
  PageTransitionType type = PageTransitionType.fade,
}) =>
    PageTransition(
      child: child,
      type: type,
      isIos: Platform.isIOS,
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      settings: settings,
    );
