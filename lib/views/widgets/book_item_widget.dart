import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf/controllers/home_controller.dart';
import 'package:read_pdf/models/books_model.dart';
import 'package:read_pdf/utils/app_theme.dart';
import 'package:gap/gap.dart';

import 'add_book_dialog.dart';

class BookItemWidget extends StatelessWidget {
  final BooksModel book;
  const BookItemWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final booksController = Get.find<HomeController>();
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.defaultBorder),
        color: Colors.white,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.defaultBorder),
            ),
            child: Image.network(
              book.coverImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Author: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: book.author),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Kitob haqida: ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: book.description,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(book.publishedDate.toString()),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor.withOpacity(0.2),
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AddBookDialog(
                                    isEdit: true,
                                    id: book.id,
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        const Gap(10),
                        //? Delete button
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor.withOpacity(0.2),
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "\"${book.title}\" Nomli kitobni O'chirishga ishonchingiz komilmi ?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          booksController.deleteBooks(book.id);
                                          Get.back();
                                        },
                                        child: const Text("Ok"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
