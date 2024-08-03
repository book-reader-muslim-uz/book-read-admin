import 'package:dio/dio.dart';
import 'package:read_pdf/core/network/dio_client.dart';
import 'package:read_pdf/models/books_model.dart';

class DioBookService {
  final _dioClient = DioClient();
  Future<List<BooksModel>> getBooks() async {
    try {
      final response = await _dioClient.get(url: "/books.json");

      final Map<String, dynamic> data = response.data;

      List<BooksModel> loadedData = [];

      data.forEach(
        (key, value) {
          value['id'] = key;
          loadedData.add(BooksModel.fromJson(value));
        },
      );

      return loadedData;
    } on DioException catch (e) {
      print("Dio error: $e");
      rethrow;
    } catch (e) {
      print("Catch error: $e");
      rethrow;
    }
  }

  Future<BooksModel> addProduct(BooksModel books) async {
    try {
      final response =
          await _dioClient.add(url: "/books.json", data: books.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add books');
      }

      final data = response.data;
      final bookId = data['name'];
      books.id = bookId;

      return BooksModel.fromJson({
        'id': bookId,
        ...data,
      });
    } on DioException catch (e) {
      print("Dio service error: $e");
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<BooksModel> updateBooks(String id, BooksModel books) async {
    try {
      final response = await _dioClient.update(
        url: "/books/$id.json",
        data: books.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update books');
      }

      return BooksModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteBooks(String id) async {
    try {
      final response = await _dioClient.delete(url: "/books/$id.json");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
