import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:read_pdf/controllers/category_controller.dart';

class CategoryFormController extends GetxController {
  final categoryController = Get.find<CategoryController>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      categoryController.addCategory(nameController.text);

      nameController.clear();

      Get.back();
    }
  }
}
