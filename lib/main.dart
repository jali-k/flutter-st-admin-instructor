import 'package:educator_app/screens/initial_screen/initial_screen.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAYxG9O0IixPAp0Ypda-YxHVnJVmaHWU0U',
      appId: '1:1090381273033:android:f4002d51f93f4d916d3a18',
      messagingSenderId: '1090381273033',
      projectId: 'educator-app-308f6',
      storageBucket: 'educator-app-308f6.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var baseTheme = ThemeData(brightness: Brightness.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.black,
          selectionHandleColor: AppColors.black,
        ),
        textTheme: GoogleFonts.aBeeZeeTextTheme(baseTheme.textTheme),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InitialScreen(),
    );
  }
}
