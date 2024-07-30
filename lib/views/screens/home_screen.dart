import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/app_theme.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/books_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: AppSize.defaultPadding,
                            ),
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSize.defaultBorder),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Barcha Categoryalar",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add,
                                        size: 25,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: 100,
                                    separatorBuilder: (context, index) =>
                                        const Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: const Divider(
                                        thickness: 0.1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10.0,
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 185,
                                              child: Text(
                                                "Item $index",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.redColor
                                                    .withOpacity(0.2),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: AppColors.redColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const BooksSection(),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
