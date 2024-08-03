// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:read_pdf/utils/app_theme.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final bool isPaddingSize;
  const DialogButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.isPaddingSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSize.defaultBorder),
          splashColor: AppColors.primaryColor.withOpacity(
            0.3,
          ),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: isPaddingSize ? 20 : 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.defaultBorder),
              color: color,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
