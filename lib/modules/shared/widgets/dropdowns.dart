import 'package:flutter/material.dart';
import 'package:ai_interview/modules/shared/widgets/colors.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool errorText;
  final Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    this.hint,
    required this.controller,
    this.prefixIcon,
    this.errorText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: TextStyle(
              color: errorText ? AppColors.danger : AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: errorText ? AppColors.danger : AppColors.black,
              ),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item.toLowerCase(),
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
