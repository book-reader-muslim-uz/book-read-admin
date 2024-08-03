import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controllers/book_form_controller.dart';
import '../../../utils/app_theme.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddBookController>();
    return Obx(
      () => Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSize.defaultBorder),
              splashColor: AppColors.primaryColor.withOpacity(
                0.3,
              ),
              onTap: controller.uploadProgress.value == 1.0
                  ? null
                  : () async {
                      await controller.selectFile();
                      if (controller.pickedFiles.value != null) {
                        await controller.uploadFile();
                      }
                    },
              child: Container(
                alignment: Alignment.center,
                // width: 350,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.defaultBorder),
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
                child: controller.pickedFiles.value == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/upload_file.png",
                            width: 30,
                          ),
                          const Gap(5.0),
                          const Text(
                            "Upload PDF book",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      )
                    : controller.uploadProgress.value == 1.0
                        ? const Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                            size: 30,
                          )
                        : const CircularProgressIndicator(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          if (controller.pickedFiles.value != null)
            Container(
              alignment: Alignment.center,
              // width: 350,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.defaultBorder),
                color: AppColors.primaryColor.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'File Name: ${controller.fileName ?? 'N/A'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('File Size: ${controller.fileSize ?? 'N/A'}'),
                    if (controller.uploadProgress.value > 0.0 &&
                        controller.uploadProgress.value < 1.0)
                      LinearProgressIndicator(
                        value: controller.uploadProgress.value,
                      ),
                    if (controller.uploadProgress.value == 1.0)
                      const Text('Upload Complete'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
