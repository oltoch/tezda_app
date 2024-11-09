import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_app/models/user_model.dart';
import 'package:tezda_app/modules/onboarding/views/login_view.dart';
import 'package:tezda_app/utils/app_data.dart';
import 'package:tezda_app/utils/locator.dart';

class ProfileController extends GetxController {
  final AppData _appData = AppData();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<UserModel?> _model = Rx<UserModel?>(null);

  UserModel? get model => _model.value;

  set model(UserModel? value) => _model.value = value;
  final _loading = false.obs;

  bool get loading => _loading.value;

  final _name = ''.obs;

  final _email = ''.obs;

  String get name => _name.value;

  set name(String value) => _name.value = value;

  String get email => _email.value;

  set email(String value) => _email.value = value;
  final _isEdit = false.obs;

  bool get isEdit => _isEdit.value;

  @override
  void onReady() {
    super.onReady();
    _getProfile();
  }

  Future<void> _getProfile() async {
    try {
      _loading.value = true;
      final res = await api.getProfile(_appData.token);
      model = res;
      setData(res);
    } catch (e) {
      debugPrint(e.toString());
      if (e.toString().contains('Unauthorized')) {
        nav.pushNamedAndRemoveUntil(LoginView.route);
        Get.snackbar(
          'Error!',
          'Your session has expired, please login again to continue.',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        _appData.clearStorage();
      }
    } finally {
      _loading.value = false;
    }
  }

  Future<void> updateProfile() async {
    if (!isEdit) {
      _isEdit.value = true;
      return;
    }
    if (loading) return;
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final body = {
      'name': name.trim(),
      'email': email.trim(),
    };
    try {
      dh.showProgressDialog(message: 'Updating Profile...');
      _loading.value = true;
      await api.updateProfile(body, model!.id);
      _isEdit.value = false;
      _getProfile();
      Get.snackbar(
        'Success!',
        'Profile updated successfully.',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Error!',
        'An error occurred! Please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } finally {
      dh.closeDialog();
      _loading.value = false;
    }
  }

  void logout() {
    _appData.clearStorage();
    nav.pushNamedAndRemoveUntil(LoginView.route);
  }

  void setData(UserModel model) {
    name = model.name;
    email = model.email;
  }
}
