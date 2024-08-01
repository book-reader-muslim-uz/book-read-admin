// controllers/add_book_controller.dart

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/controllers/home_controller.dart';
import 'package:read_pdf/controllers/category_controller.dart';
import 'dart:io' as io;
import 'package:flutter/foundation.dart' as foundation;

import '../models/categories_model.dart';

class AddBookController extends GetxController {
  final CategoryController categoryController = Get.find();
  final HomeController homeController = Get.find();

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final pdfUrlController = TextEditingController();
  final coverImageUrlController = TextEditingController();
  final publishedDateController = TextEditingController();
  final categoriesController = TextEditingController();

  RxBool isExpanded = false.obs;
  RxString genre = ''.obs;
  RxString categoryId = ''.obs;
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;
  RxList<CategoriesModel> filteredCategories = <CategoriesModel>[].obs;
  RxString categorySearchQuery = ''.obs;
  Rxn<PlatformFile> pickedFiles = Rxn<PlatformFile>();
  Rxn<UploadTask> uploadTask = Rxn<UploadTask>();
  RxDouble uploadProgress = 0.0.obs;
  RxString? fileName = ''.obs;
  RxString? fileSize = ''.obs;

  @override
  void onInit() {
    _loadCategories();
    super.onInit();
  }

  Future<void> _loadCategories() async {
    categories.value = categoryController.categories;
    filteredCategories.value = categories;
  }

  void filterCategories(String query) {
    categorySearchQuery.value = query;
    filteredCategories.value = categories
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void selectCategory(String id) {
    categoryId.value = id;
    categorySearchQuery.value = categoryController.getCategoryNameById(id);
  }

  bool isValidURL(String url) {
    const urlPattern = r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$';
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub', 'pdf'],
    );
    if (result == null) return;

    pickedFiles.value = result.files.first;
    fileName!.value = pickedFiles.value!.name;
    fileSize!.value = (pickedFiles.value?.bytes?.length ?? 0) > 1024 * 1024
        ? '${(pickedFiles.value!.bytes!.length / (1024 * 1024)).toStringAsFixed(2)} MB'
        : '${(pickedFiles.value!.bytes!.length / 1024).toStringAsFixed(2)} KB';
  }

  Future<void> uploadFile() async {
    if (pickedFiles.value == null) return;

    try {
      final path = 'files/${pickedFiles.value!.name}';
      final ref = FirebaseStorage.instance.ref().child(path);

      final task = foundation.kIsWeb
          ? ref.putData(pickedFiles.value!.bytes!)
          : ref.putFile(io.File(pickedFiles.value!.path!));

      task.snapshotEvents.listen((event) {
        uploadProgress.value =
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      });

      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      pdfUrlController.text = urlDownload;
      uploadTask.value = null;
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final book = BooksModel(
        id: UniqueKey().toString(),
        title: titleController.text,
        author: authorController.text,
        description: descriptionController.text,
        pdfUrl: pdfUrlController.text,
        coverImageUrl: coverImageUrlController.text,
        publishedDate: publishedDateController.text,
        genre: categoriesController.text,
        categoryId: categoryId.value,
      );

      homeController.addBooks(book);
      Get.back();
    }
  }
}
