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

  Future<void> addCategory(String name) async {
    try {
      isLoading(true);
      final result = await dioCategoryService.addCategories(name);
      fetchCategories();
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
  }

  Future<void> deleteCategory(String id) async {
    try {
      isLoading(true);
      await dioCategoryService.deleteCategories(id);
      fetchCategories();
      
    } catch (e) {
      errorMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
