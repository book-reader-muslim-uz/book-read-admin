import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/book_form_controller.dart';
import 'diolog_widgets/category_form_field.dart';
import 'diolog_widgets/file_upload_section.dart';
import 'diolog_widgets/text_form_fields.dart';

class AddBookDialog extends StatelessWidget {
  final AddBookController controller = Get.put(AddBookController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Book'),
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
                const SizedBox(height: 16.0),
                const FileUploadSection()
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: controller.submitForm,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}