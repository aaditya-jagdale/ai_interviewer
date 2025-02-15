import 'package:ai_interview/modules/shared/api/onboarding_api.dart';
import 'package:ai_interview/modules/shared/screens/main_screen.dart';
import 'package:ai_interview/modules/shared/widgets/buttons.dart';
import 'package:ai_interview/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:ai_interview/modules/shared/widgets/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        // child: SvgPicture.asset('assets/icons/logo_white.svg'),
                      ),
                    ),
                  ),
                  Text(
                    'Ready to Ace your next interview?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  _loading
                      ? SizedBox.shrink() // Placeholder to prevent layout shift
                      : PrimaryButton(
                          icon: SvgPicture.asset("assets/icons/google.svg"),
                          title: 'Continue with Google',
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            try {
                              final response =
                                  await OnboardinApi().googleSignIn();
                              if (response.user != null) {
                                clearAllAndPush(context, MainScreen());
                              }
                            } catch (error) {
                              // Optionally handle the error (e.g., show a snackbar)
                              print('OAuth process failed: $error');
                            } finally {
                              setState(() {
                                _loading = false;
                              });
                            }
                          }),
                  SizedBox(height: 10),
                  Text(
                    'By continuing, you and agree to our terms of use',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            if (_loading)
              Center(
                child: CustomProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
