import 'package:ai_interview/modules/shared/screens/landing_screen.dart';
import 'package:ai_interview/modules/shared/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ai_interview/modules/shared/widgets/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = Supabase.instance.client;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Interview',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whitebg,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
        ),
        textTheme: GoogleFonts.instrumentSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: supabase.auth.currentUser == null
          ? const LandingScreen()
          : const MainScreen(),
    );
  }
}
