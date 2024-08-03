import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:read_pdf/views/widgets/categories_container_section.dart';
import 'package:read_pdf/views/widgets/categories_section.dart';
import '../../utils/app_theme.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/books_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFDEE0E7),
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.defaultPadding,
          right: AppSize.defaultPadding,
        ),
        child: SingleChildScrollView(
          child: MediaQuery.of(context).size.width >= 990
              ? Column(
                  children: [
                    const Gap(50),
                    Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width - 300,
                          child: const BooksSection(),
                        ),
                        const Gap(10.0),
                        const CategoriesSection()
                      ],
                    ),
                    const Gap(30),
                  ],
                )
              : Column(
                  children: [
                    const Gap(50),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const BooksSection(),
                    ),
                    const Gap(20),
                    const CategoriesContainerSection(),
                    const Gap(20.0),
                  ],
                ),
        ),
      ),
    );
  }
}
