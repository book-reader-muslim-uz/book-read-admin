import 'package:get/get.dart';
import 'package:read_pdf/models/books_model.dart';
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
      final fetchedBooks = await dioBookService.getProducts();
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
}
