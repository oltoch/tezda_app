import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_app/utils/locator.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString _firstName = ''.obs;
  final RxString _lastName = ''.obs;
  final RxString _email = ''.obs;

  final RxString _password = ''.obs;
  final RxBool _passwordVisibility = true.obs;

  final RxString _confirmPassword = ''.obs;
  final RxBool _confirmPasswordVisibility = true.obs;

  String get firstName => _firstName.value;

  set firstName(String value) => _firstName.value = value;

  String get lastName => _lastName.value;

  set lastName(String value) => _lastName.value = value;

  String get email => _email.value;

  set email(String value) => _email.value = value;

  String get password => _password.value;

  set password(String value) => _password.value = value;

  bool get passwordVisibility => _passwordVisibility.value;

  set passwordVisibility(bool value) => _passwordVisibility.value = value;

  String get confirmPassword => _confirmPassword.value;

  set confirmPassword(String value) => _confirmPassword.value = value;

  bool get confirmPasswordVisibility => _confirmPasswordVisibility.value;

  set confirmPasswordVisibility(bool value) =>
      _confirmPasswordVisibility.value = value;

  bool get enabled =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) return;

    final body = {
      'name': '${firstName.trim()} ${lastName.trim()}',
      'avatar': 'https://dummyjson.com/image/300?text=IMAGE',
      'email': email.trim(),
      'password': password,
    };
    try {
      dh.showProgressDialog(message: 'Creating user...');
      await api.registerUser(body);
      Get.snackbar(
        'Success!',
        'User created! Login with your email and password to continue.',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      nav.pop();
    } catch (e) {
      debugPrint(e.toString());

      Get.snackbar(
        'Error!',
        'An error occurred, please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } finally {
      dh.closeDialog();
    }
  }
}
