import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf/utils/app_theme.dart';
import 'package:read_pdf/views/widgets/add_book_dialog.dart';
import 'package:read_pdf/views/widgets/book_item_widget.dart';

import '../../controllers/home_controller.dart';

class BooksSection extends StatefulWidget {
  const BooksSection({super.key});

  @override
  State<BooksSection> createState() => _TestColumnState();
}

class _TestColumnState extends State<BooksSection> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                "Barcha PDF kitoblar",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const AddBookDialog(isEdit: false,);
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                size: 25,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.errorMessage.isNotEmpty) {
            return const Center(
              child: Text(
                  "Mahsulotlar topilmadi, qo'shish uchun (+) tugamsini bosing"),
            );
          } else if (controller.books.isEmpty) {
            return const Center(
              child: Text('No books found.'),
            );
          }

          return Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 250).floor() == 0
                        ? 1
                        : (MediaQuery.of(context).size.width / 250).floor(),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                mainAxisExtent: 440,
              ),
              scrollDirection: Axis.vertical,
              itemCount: controller.books.length,
              itemBuilder: (context, index) {
                // print((MediaQuery.of(context).size.width / 250).floor());
                final book = controller.books[index];
                return BookItemWidget(book: book);
              },
            ),
          );
        }),
      ],
    );
  }
}
