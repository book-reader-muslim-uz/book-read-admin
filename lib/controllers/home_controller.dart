import 'package:get/get.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/models/categories_model.dart';
import 'package:read_pdf/services/dio_category_service.dart';
import '../../services/dio_book_service.dart';

class HomeController extends GetxController {
  final DioBookService dioBookService = DioBookService();

  var books = <BooksModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  Future<void> fetchBooks() async {
    try {
      isLoading(true);
      final fetchedBooks = await dioBookService.getBooks();
      if (fetchedBooks != null) {
        books.assignAll(fetchedBooks);
      } else {
        errorMessage('No books found.');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addBooks(BooksModel books) async {
    try {
      isLoading(true);
      final res = await dioBookService.addProduct(books);

      print(res);
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
