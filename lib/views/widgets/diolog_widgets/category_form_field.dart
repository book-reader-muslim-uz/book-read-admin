import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controllers/book_form_controller.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddBookController>();

    return Obx(
      () => Column(
        children: [
          TextFormField(
            controller: controller.categoriesController,
            onChanged: (value) => controller.filterCategories(value),
            onTap: () => controller.isExpanded.value = true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              labelText: 'Select Genre',
            ),
            validator: (value) =>
                value!.isEmpty ? 'Please select a category' : null,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: controller.isExpanded.value ? 150 : 0,
            child: ListView.builder(
              itemCount: controller.filteredCategories.length,
              itemBuilder: (context, index) {
                final category = controller.filteredCategories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    controller.selectCategory(category.categoryId);
                    controller.categoriesController.text = category.name;
                    controller.isExpanded.value = false;
                  },
                );
              },
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
