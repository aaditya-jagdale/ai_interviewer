import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for a String value
final navBarProvider = StateNotifierProvider<NavBarNotifier, int>((ref) {
  return NavBarNotifier();
});

// StateNotifier class to manage the state of the token
class NavBarNotifier extends StateNotifier<int> {
  NavBarNotifier() : super(0);

  // Method to update the token
  void update(int value) {
    state = value;
  }
}
