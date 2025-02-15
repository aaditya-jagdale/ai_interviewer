import 'dart:ui';

import 'package:ai_interview/modules/shared/widgets/colors.dart';
import 'package:ai_interview/riverpod/navbar_rvpd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0), // Optional: Rounded corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navBarButton('assets/icons/home.svg', 0),
                _navBarButton('assets/icons/file.svg', 1, onTap: () {}),
                _navBarButton('assets/icons/list.svg', 2, onTap: () {}),
                _navBarButton('assets/icons/person.svg', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navBarButton(String icon, int index, {Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap?.call();
          ref.read(navBarProvider.notifier).update(index);
        },
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 22),
          color: Colors.transparent, // Transparent to maintain glass effect
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              ref.watch(navBarProvider) == index
                  ? AppColors.black
                  : AppColors.black25,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
