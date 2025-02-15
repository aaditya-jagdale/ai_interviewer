import 'package:flutter/material.dart';
import 'package:ai_interview/modules/shared/widgets/colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool enabled;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.title,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.enabled = true,
    this.errorText,
    this.keyboardType,
    this.onTap,
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
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          enabled: enabled,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hint,
            hintStyle: const TextStyle(
                color: AppColors.grey, fontWeight: FontWeight.normal),
            prefixIcon: prefixIcon,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
            ),
          ),
        ),
      ],
    );
  }
}
