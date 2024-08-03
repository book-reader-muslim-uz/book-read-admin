/* import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:read_pdf/controllers/home_controller.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/services/dio_book_service.dart';

class MockDioBookService extends Mock implements DioBookService {}

void main() {
  group("Home Controller", () {
    late HomeController homeController;
    late DioBookService mockDioBookService;

    setUp(() {
      mockDioBookService = MockDioBookService();
      homeController = HomeController();
      homeController.dioBookService = mockDioBookService;
    });
    test("Fetch Books should update books and handle errors", () async {
      final books = [
        BooksModel(
          id: "1",
          title: "Book 1",
          author: "Test Author",
          description: "Test description",
          pdfUrl: "https://imgs.search.brave.com/nC7CJkotrDe7xJDCrYahXgC2gS5kJ8xhkr3Zc6II6KY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzE3L2E0/Lzk3LzE3YTQ5NzRk/NzFmNzRlYTdjY2Fk/YTA1ODQ4Mzc5NjRh/LmpwZw",
          coverImageUrl: "https://imgs.search.brave.com/nC7CJkotrDe7xJDCrYahXgC2gS5kJ8xhkr3Zc6II6KY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzE3L2E0/Lzk3LzE3YTQ5NzRk/NzFmNzRlYTdjY2Fk/YTA1ODQ4Mzc5NjRh/LmpwZw",
          publishedDate: "2000",
          genre: "Fantastic",
          categoryId: "testCatId",
        ),
      ];

      when(mockDioBookService.getBooks()).thenAnswer((_) async => books);

      // await homeController.fetchBooks();

      // expect(homeController.books, books);
      // expect(homeController.isLoading, true);
      // expect(homeController.errorMessage, "");
    });
  });
}
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/services/dio_book_service.dart';
import 'package:read_pdf/controllers/home_controller.dart';

class MockDioBookService extends Mock implements DioBookService {}

void main() {
  group('HomeController', () {
    late HomeController homeController;
    late MockDioBookService mockDioBookService;

    setUp(() {
      mockDioBookService = MockDioBookService();
      homeController = HomeController();
      homeController.dioBookService = mockDioBookService;
    });

    test('fetchBooks updates books and isLoading', () async {
      final books = [
        BooksModel(
          id: "1",
          title: "Book 1",
          author: "Test Author",
          description: "Test description",
          pdfUrl:
              "https://imgs.search.brave.com/nC7CJkotrDe7xJDCrYahXgC2gS5kJ8xhkr3Zc6II6KY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzE3L2E0/Lzk3LzE3YTQ5NzRk/NzFmNzRlYTdjY2Fk/YTA1ODQ4Mzc5NjRh/LmpwZw",
          coverImageUrl:
              "https://imgs.search.brave.com/nC7CJkotrDe7xJDCrYahXgC2gS5kJ8xhkr3Zc6II6KY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzE3L2E0/Lzk3LzE3YTQ5NzRk/NzFmNzRlYTdjY2Fk/YTA1ODQ4Mzc5NjRh/LmpwZw",
          publishedDate: "2000",
          genre: "Fantastic",
          categoryId: "testCatId",
        ),
        // BooksModel(id: '2', title: 'Book 2'),
      ];
      when(mockDioBookService.getBooks()).thenAnswer((_) async => books);

      await homeController.fetchBooks();

      expect(homeController.books.length, 1);
      expect(homeController.isLoading.value, false);
      expect(homeController.books[0].title, 'Book 1');
    });
  });
}
