import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:read_pdf/controllers/category_form_controller.dart';
import 'package:read_pdf/views/widgets/diolog_widgets/dialog_button.dart';

import '../../../utils/app_theme.dart';
import 'text_form_fields.dart';

class CategoryDialogForm extends StatelessWidget {
  final CategoryFormController categoryFormController;
  const CategoryDialogForm({
    super.key,
    required this.categoryFormController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Category qo'shish"),
      content: Form(
        key: categoryFormController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BuildTextFormField(
              controller: categoryFormController.nameController,
              label: 'Title',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
            ),
            const Gap(20),
            Row(
              children: [
                DialogButton(
                  text: "Cancel",
                  onTap: () => Get.back(),
                  color: AppColors.primaryColor.withOpacity(0.2),
                  textColor: AppColors.primaryColor,
                  isPaddingSize: false,
                ),
                const Gap(AppSize.defaultPadding),
                DialogButton(
                  text: "Submit",
                  onTap: () {
                    categoryFormController.submitForm();
                  },
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  isPaddingSize: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
