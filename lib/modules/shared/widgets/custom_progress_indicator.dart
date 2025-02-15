import 'package:flutter/material.dart';
import 'package:ai_interview/modules/shared/widgets/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color color;
  const CustomProgressIndicator({super.key, this.color = AppColors.blackbg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: color,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
