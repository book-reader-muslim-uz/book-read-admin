import 'package:flutter/material.dart';
import 'package:read_pdf/utils/app_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      toolbarHeight: 80,
      elevation: 5,
      title: const Text(
        "Hello User",
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "User",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Super admin",
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            "https://imgs.search.brave.com/sZBG4kb4evGSJ4DWTxIjRVdzjGlFqSAGpZV77hwSkT0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4Lzc2LzQ2LzA4/LzM2MF9GXzg3NjQ2/MDgxNF9ubk1yZUo4/TURuSVZWUU8wS3Vw/M3FPUEhUT3hvMWo3/NS5qcGc",
          ),
        ),
      ],
    );
  }
}
