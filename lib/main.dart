import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/utilities/colors.dart';
import 'package:task/views/meal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        primaryColor: AppColors.primary,
        secondaryHeaderColor: AppColors.background
      ),
      home: const MealScreen()
    );
  }
}
