import 'package:dio/dio.dart';
import 'package:read_pdf/core/network/dio_client.dart';
import 'package:read_pdf/models/books_model.dart';

class DioBookService {
  final _dioClient = DioClient();
  Future<List<BooksModel>> getProducts() async {
    try {
      final response = await _dioClient.get(url: "/books.json");

      final Map<String, dynamic> data = response.data;

      List<BooksModel> products = data.values.map((item) {
        return BooksModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      print(products);
      return products;
    } on DioException catch (e) {
      print("Dio error: $e");
      rethrow;
    } catch (e) {
      print("Catch error: $e");
      rethrow;
    }
  }

  Future<BooksModel> addProduct(BooksModel product) async {
    try {
      final response =
          await _dioClient.add(url: "/books.json", data: product.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add product');
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
//   final res = await dioBookService.addProduct(
//     BooksModel(
//       id: "2",
//       title: "To Kill a Mockingbird",
//       author: "Harper Lee",
//       description: "A novel about racial injustice in the Deep South.",
//       pdfUrl: "https://example.com/to-kill-a-mockingbird.pdf",
//       coverImageUrl:
//           "https://imgs.search.brave.com/auk-E0hDBkGSZyV-L-dAs2vSi4WoxcULzv5erF-5sI0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzY3LzIy/LzA1LzY3MjIwNWYz/NGE5NDljM2ZmYTc1/Mjk0NDA1MjgwNmVj/LmpwZw",
//       publishedDate: "1960",
//       genre: "Fiction",
//       categoryId: "category2",
//     ),
//   );

//   print(res);
// }
