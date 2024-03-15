import 'package:flutter/material.dart';
import 'package:task/utilities/colors.dart';

import '../widgets/meal_tile_widget.dart';
class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  List<IconData> icons = [
    Icons.sunny_snowing,
    Icons.file_copy_rounded,
    Icons.sunny,
    Icons.nightlight,
    Icons.nights_stay,
    Icons.access_time_filled
  ];
  List<String> mealNo = [
    "One","Two","Three", "Four","Five","Six"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Meals", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark, color: AppColors.primary,)),
                      PopupMenuButton(itemBuilder: (context) {
                        return [
                          const PopupMenuItem(child: Text("Option 1")),
                          const PopupMenuItem(child: Text("Option 2")),
                          const PopupMenuItem(child: Text("Option 3"))
                        ];
                      },)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height-100,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder : (context, index) {
                  return MealTile(icon: icons[index],mealNo:mealNo[index]);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}