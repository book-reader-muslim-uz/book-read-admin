import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:read_pdf/models/admin_model.dart';
import 'package:read_pdf/services/dio_admin_service.dart';

import '../views/screens/home_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();

  final DioAdminService _dioAdminService = DioAdminService();

  RxBool isLoading = false.obs;
  RxBool isLogin = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isPasswordVisible = false.obs;

  void submit() async {
    if (formKey.currentState?.validate() ?? false) {
      _performLogin();
    }
  }

  Future<void> _performLogin() async {
    isLoading.value = true;
    final fullName = fullNameController.text;
    final password = passwordController.text;

    try {
      final admins = await _dioAdminService.getAdmins();
      final admin = admins.firstWhere(
        (admin) => admin.name == fullName,
        orElse: () => AdminModel(id: "", name: "", password: ""),
      );

      if (admin.id.isNotEmpty) {
        final isPasswordCorrect =
            await _dioAdminService.verifyPassword(password, admin.password);
        if (isPasswordCorrect) {
          isLogin.value = true;
          Get.offAll(() => const HomeScreen());
        } else {
          errorMessage.value = 'Invalid password';
        }
      } else {
        errorMessage.value = 'Admin not found';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
