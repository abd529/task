import 'package:flutter/material.dart';
import 'package:task/utilities/colors.dart';
import '../widgets/meal_tile_widget.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  static const List<IconData> _icons = [
    Icons.sunny_snowing,
    Icons.file_copy_rounded,
    Icons.sunny,
    Icons.nightlight,
    Icons.nights_stay,
    Icons.access_time_filled,
  ];
  static const List<String> _mealNo = [
    "One", "Two", "Three", "Four", "Five", "Six",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const _MealHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: _icons.length,
                itemBuilder: (context, index) {
                  return MealTile(icon: _icons[index], mealNo: _mealNo[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealHeader extends StatelessWidget {
  const _MealHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Meals",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark, color: AppColors.primary),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text("Option 1")),
                  const PopupMenuItem(child: Text("Option 2")),
                  const PopupMenuItem(child: Text("Option 3")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
