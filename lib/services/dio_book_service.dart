import 'package:dio/dio.dart';
import 'package:read_pdf/core/network/dio_client.dart';
import 'package:read_pdf/models/books_model.dart';

class DioBookService {
  final _dioClient = DioClient();
  Future<List<BooksModel>> getBooks() async {
    try {
      final response = await _dioClient.get(url: "/test_books.json");

      final Map<String, dynamic> data = response.data;

      List<BooksModel> books = data.values.map((item) {
        return BooksModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      print(books);
      return books;
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
          await _dioClient.add(url: "/test_books.json", data: books.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add books');
      }

      print("service response: $response");

      return BooksModel.fromJson(response.data);
    } on DioException catch (e) {
      print("Dio service error: $e");
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

// void main(List<String> args) async {
//   DioBookService dioBookService = DioBookService();
//   dioBookService.getBooks();
// }
