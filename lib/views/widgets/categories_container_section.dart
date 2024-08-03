import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/category_form_controller.dart';
import '../../utils/app_theme.dart';
import 'diolog_widgets/category_dialog_form.dart';

class CategoriesContainerSection extends StatefulWidget {
  const CategoriesContainerSection({super.key});

  @override
  State<CategoriesContainerSection> createState() =>
      _CategoriesContainerSectionState();
}

class _CategoriesContainerSectionState
    extends State<CategoriesContainerSection> {
  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());
  final categoryFormController = Get.put(CategoryFormController());


    return Container(
      padding: const EdgeInsets.only(
        left: AppSize.defaultPadding,
      ),
      height: MediaQuery.of(context).size.height - 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.defaultBorder),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Barcha Categoryalar",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CategoryDialogForm(
                        categoryFormController: categoryFormController,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 25,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Obx(
            () {
              if (categoryController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (categoryController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(categoryController.errorMessage.value),
                );
              } else if (categoryController.categories.isEmpty) {
                return const Center(
                  child: Text('No books found.'),
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemCount: categoryController.categories.length,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Divider(
                      thickness: 0.1,
                      color: Colors.black12,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final category = categoryController.categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        bottom: 8,
                        top: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 185,
                            child: Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.redColor.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // print(category.id);
                                categoryController.deleteCategory(category.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
