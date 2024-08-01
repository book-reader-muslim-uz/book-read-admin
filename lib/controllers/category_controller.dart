// import 'package:get/get.dart';

// import '../models/categories_model.dart';
// import '../services/dio_category_service.dart';

// class CategoryController extends GetxController {
//   final DioCategoryService dioCategoryService = DioCategoryService();
//   var categories = <CategoriesModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     fetchCategories();
//     super.onInit();
//   }


//   Future<void> fetchCategories() async {
//     try {
//       isLoading(true);
//       final fetchCategories = await dioCategoryService.getCategories();
//       if (fetchCategories != null) {
//         categories.assignAll(fetchCategories);
//       } else {
//         errorMessage("Fetch Qilishda muammo bor");
//       }
//     } catch (e) {
//       errorMessage("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

// }

import 'package:get/get.dart';

import '../models/categories_model.dart';
import '../services/dio_category_service.dart';

class CategoryController extends GetxController {
  final DioCategoryService dioCategoryService = DioCategoryService();
  var categories = <CategoriesModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final fetchCategories = await dioCategoryService.getCategories();
      if (fetchCategories != null) {
        categories.assignAll(fetchCategories);
      } else {
        errorMessage("Fetch Qilishda muammo bor");
      }
    } catch (e) {
      errorMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  String getCategoryNameById(String id) {
    final category = categories.firstWhereOrNull((cat) => cat.id == id);
    return category?.name ?? 'Unknown Category';
  }

  List<CategoriesModel> filterCategories(String query) {
    return categories
        .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Add a new category
  /* Future<void> addCategory(CategoriesModel category) async {
    try {
      isLoading(true);
      final result = await dioCategoryService.addCategory(category);
      if (result != null) {
        categories.add(result);
      } else {
        errorMessage("Category qo'shishda muammo bor");
      }
    } catch (e) {
      errorMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  } */

  // Update an existing category
  /* Future<void> updateCategory(CategoriesModel category) async {
    try {
      isLoading(true);
      final result = await dioCategoryService.updateCategory(category);
      if (result != null) {
        final index = categories.indexWhere((cat) => cat.id == category.id);
        if (index != -1) {
          categories[index] = result;
        }
      } else {
        errorMessage("Category yangilashda muammo bor");
      }
    } catch (e) {
      errorMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  } */

  // Delete a category
  /* Future<void> deleteCategory(String id) async {
    try {
      isLoading(true);
      final success = await dioCategoryService.deleteCategory(id);
      if (success) {
        categories.removeWhere((cat) => cat.id == id);
      } else {
        errorMessage("Category o'chirishda muammo bor");
      }
    } catch (e) {
      errorMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  } */
}