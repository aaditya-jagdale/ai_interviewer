import 'package:ai_interview/modules/resume/screens/resume_screen.dart';
import 'package:ai_interview/modules/shared/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_interview/riverpod/navbar_rvpd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<Widget> screens = [
    const Scaffold(),
    const ResumeScreen(),
    const Scaffold(),
    const Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: screens[ref.watch(navBarProvider)]),
          const CustomBottomNavBar()
        ],
      ),
    );
  }
}
