import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:read_pdf/utils/app_theme.dart';
import 'package:read_pdf/views/widgets/diolog_widgets/dialog_button.dart';

import '../../controllers/book_form_controller.dart';
import 'diolog_widgets/category_form_field.dart';
import 'diolog_widgets/file_upload_section.dart';
import 'diolog_widgets/text_form_fields.dart';

class AddBookDialog extends StatefulWidget {
  final bool isEdit;
  final String? id;

  const AddBookDialog({
    super.key,
    required this.isEdit,
    this.id,
  });

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final AddBookController controller = Get.put(AddBookController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.isEdit ? const Text("Edit Book") : const Text('Add Book'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildTextFormField(
                  controller: controller.titleController,
                  label: 'Title',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                ),
                BuildTextFormField(
                  controller: controller.authorController,
                  label: 'Author',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an author' : null,
                ),
                BuildTextFormField(
                  controller: controller.descriptionController,
                  label: 'Description',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a description' : null,
                ),
                BuildTextFormField(
                  controller: controller.publishedDateController,
                  label: 'Published Date',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a published date' : null,
                ),
                const CategoryFormField(),
                BuildTextFormField(
                  controller: controller.coverImageUrlController,
                  label: 'Cover Image URL',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a cover image URL';
                    if (!controller.isValidURL(value)) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                ),
                const Gap(16.0),
                const FileUploadSection(),
                const Gap(20.0),
                Row(
                  children: [
                    DialogButton(
                      text: "Cancel",
                      onTap: () => Get.back(),
                      color: AppColors.primaryColor.withOpacity(0.2),
                      textColor: AppColors.primaryColor,
                      isPaddingSize: true,
                    ),
                    const Gap(AppSize.defaultPadding),
                    DialogButton(
                      text: "Submit",
                      onTap: () {
                        widget.isEdit
                            ? controller.editSubmitForm(widget.id!)
                            : controller.submitForm();
                      },
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      isPaddingSize: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
