import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_app/modules/product/views/product_list_view.dart';
import 'package:tezda_app/utils/app_data.dart';
import 'package:tezda_app/utils/locator.dart';

class LoginController extends GetxController {
  final AppData _appData = AppData();

  final _email = ''.obs;
  final _password = ''.obs;
  final _passwordVisibility = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get email => _email.value;

  set email(String value) => _email.value = value;

  String get password => _password.value;

  set password(String value) => _password.value = value;

  bool get passwordVisibility => _passwordVisibility.value;

  set passwordVisibility(bool value) => _passwordVisibility.value = value;

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) return;
    final body = {
      'email': email,
      'password': password,
    };
    try {
      dh.showProgressDialog(message: 'Logging in...');
      final res = await api.loginUser(body);
      _appData.token = res.accessToken;
      _appData.email = email;
      nav.pushNamed(ProductListView.route);
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Error!',
        'Invalid login credentials',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } finally {
      dh.closeDialog();
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (_appData.email.isNotEmpty) {
      email = _appData.email;
    }
  }
}
