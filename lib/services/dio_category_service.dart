import 'package:dio/dio.dart';
import 'package:read_pdf/core/network/dio_client.dart';
import 'package:read_pdf/models/categories_model.dart';

class DioCategoryService {
  final _dioClient = DioClient();
  Future<List<CategoriesModel>> getCategories() async {
    try {
      final response = await _dioClient.get(url: "/categories.json");

      Map<String, dynamic> data = response.data;

      // List<CategoriesModel> categories = data.values.map((catItem) {
      //   return CategoriesModel.fromJson(catItem as Map<String, dynamic>);
      // }).toList();
      List<CategoriesModel> loadedData = [];
      data.forEach((key, value) {
        value['id'] = key;
        value['categoryId'] = key;
        loadedData.add(CategoriesModel.fromJson(value));
      });

      // print(loadedData);

      // print(data.keys);
      return loadedData;
    } on DioException catch (e) {
      print("Service Dio error: $e");
      rethrow;
    } catch (e) {
      print("Category catch Erro: $e");
      rethrow;
    }
  }

  Future<CategoriesModel> addCategories(String name) async {
    try {
      Map<String, dynamic> categoryData = {
        'name': name,
      };

      final response =
          await _dioClient.add(url: "/categories.json", data: categoryData);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add category');
      }

      print("Category ID: $response");

      final data = response.data;
      categoryData['id'] = data['name'];
      categoryData['categoryId'] = data['name'];
      // print(data);

      CategoriesModel categoriesModel = CategoriesModel.fromJson(categoryData);
      return categoriesModel;
    } on DioException catch (e) {
      print("Dio category added error: $e");
      rethrow;
    } catch (e) {
      print("Category added catch error: $e");
      rethrow;
    }
  }
}

void main(List<String> args) async {
  DioCategoryService dioCategoryService = DioCategoryService();
  final res = await dioCategoryService.addCategories("Abdulloh");

  print(res.name);
  print(res.categoryId);
}
