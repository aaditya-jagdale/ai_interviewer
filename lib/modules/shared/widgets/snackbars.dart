import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

OverlayEntry? currentOverlay;
Timer? currentTimer; // Timer to control the snackbar duration

void removeCurrentOverlay() {
  currentTimer?.cancel(); // Cancel any existing timer
  currentOverlay?.remove(); // Remove the existing overlay
  currentOverlay = null;
}

void showSnackBar(BuildContext context, String? message,
    {bool isSuccess = true}) {
  removeCurrentOverlay(); // Ensure no previous snackbar is active

  // Determine snackbar styling based on success or error
  final gradientColors = isSuccess
      ? [Color(0xFF56ab2f), Color(0xFFB6EF70)] // Green gradient
      : [Color(0xFFe52d27), Color(0xFFff6b6b)]; // Red gradient
  final icon = isSuccess ? Icons.check_circle : Icons.error;
  final defaultMessage = isSuccess ? 'Success!' : 'An error occurred!';

  currentOverlay = OverlayEntry(
    builder: (context) => Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message ?? defaultMessage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  removeCurrentOverlay();
                },
              ),
            ],
          ),
        )
            .animate() // Start the animation
            .fadeIn(duration: 300.ms) // Fade in
            .slideY(begin: -1, end: 0, duration: 300.ms), // Slide down
      ),
    ),
  );

  Overlay.of(context).insert(currentOverlay!);

  // Set up the timer to remove the snackbar after 3 seconds
  currentTimer = Timer(const Duration(seconds: 3), () {
    removeCurrentOverlay();
  });
}

void successSnackBar(BuildContext context, String? message) {
  showSnackBar(context, message, isSuccess: true);
}

void errorSnackBar(BuildContext context, String? message) {
  showSnackBar(context, message, isSuccess: false);
}
