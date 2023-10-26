import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/tabs.dart';

//setting the dark theme for the entire application
final theme = ThemeData(
  useMaterial3: true, //setting material3 as true - ignores default
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0), // Define the primary color.
  ),
  textTheme: GoogleFonts.latoTextTheme(), // Use Google Fonts for text styling.
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
//widget of the application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,   // Apply the defined theme to the entire app.
      home: const TabsScreen(), // Set the initial home screen to TabsScreen.
    );
  }
}
