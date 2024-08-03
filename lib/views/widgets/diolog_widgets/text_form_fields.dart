import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BuildTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;

  const BuildTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
          validator: validator,
        ),
        const Gap(10),
      ],
    );
  }
}
