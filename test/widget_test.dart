// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:read_pdf/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}



/* 

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'package:read_pdf/controllers/home_controller.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/services/dio_book_service.dart';

// Mock class for DioBookService
class MockDioBookService extends Mock implements DioBookService {}

void main() {
  late HomeController homeController;
  late MockDioBookService mockDioBookService;

  setUp(() {
    mockDioBookService = MockDioBookService();
    homeController = HomeController();
    homeController.dioBookService = mockDioBookService; // Inject the mock
  });

  group('HomeController', () {
    test('fetchBooks should update books and handle errors', () async {
      final books = [BooksModel(id: '1', title: 'Book 1')];
      
      when(mockDioBookService.getBooks()).thenAnswer((_) async => books);

      await homeController.fetchBooks();

      expect(homeController.books, books);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, '');
    });

    test('fetchBooks should handle no books found', () async {
      when(mockDioBookService.getBooks()).thenAnswer((_) async => null);

      await homeController.fetchBooks();

      expect(homeController.books, []);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, 'No books found.');
    });

    test('fetchBooks should handle exceptions', () async {
      when(mockDioBookService.getBooks()).thenThrow(Exception('Test error'));

      await homeController.fetchBooks();

      expect(homeController.books, []);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, 'Error: Exception: Test error');
    });

    test('addBooks should add a book and handle errors', () async {
      final book = BooksModel(id: '2', title: 'Book 2');

      when(mockDioBookService.addProduct(book)).thenAnswer((_) async => 'Success');
      when(mockDioBookService.getBooks()).thenAnswer((_) async => [book]);

      await homeController.addBooks(book);

      expect(homeController.books, [book]);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, '');
    });

    test('updateBooks should update a book and handle errors', () async {
      final book = BooksModel(id: '1', title: 'Updated Book');

      when(mockDioBookService.updateBooks(book)).thenAnswer((_) async => 'Success');
      when(mockDioBookService.getBooks()).thenAnswer((_) async => [book]);

      await homeController.updateBooks(book);

      expect(homeController.books, [book]);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, '');
    });

    test('deleteBooks should delete a book and handle errors', () async {
      final bookId = '1';

      when(mockDioBookService.deleteBooks(bookId)).thenAnswer((_) async => 'Success');
      when(mockDioBookService.getBooks()).thenAnswer((_) async => []);

      await homeController.deleteBooks(bookId);

      expect(homeController.books, []);
      expect(homeController.isLoading.value, false);
      expect(homeController.errorMessage.value, '');
    });
  });
}

 */