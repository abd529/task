import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/utilities/colors.dart';

import '../../data/models/food_model.dart';
import '../../provider/meal_provider.dart';
import 'curved_custom_paint.dart';

class MealTile extends StatelessWidget {
  final IconData icon;
  final String mealNo;

  const MealTile({
    super.key,
    required this.icon,
    required this.mealNo,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealTileState(),
      child: _MealTileContent(icon: icon, mealNo: mealNo),
    );
  }
}

class _MealTileContent extends StatelessWidget {
  final IconData icon;
  final String mealNo;

  const _MealTileContent({
    required this.icon,
    required this.mealNo,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MealTileState>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: CurvedCornerPainter(),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => state.addItem(),
                    child: Container(
                      height: 72,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: state.foods.isNotEmpty ? 170 + (state.foods.length * 60) : 106,
                  padding: const EdgeInsets.all(08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 70,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(icon, color: AppColors.primary),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meal $mealNo',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              state.foods.isNotEmpty
                                  ? Row(
                                      children: [
                                        state.isEdit
                                            ? InkWell(
                                                onTap: () => state.toggleEdit(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15),
                                                    border: Border.all(color: Colors.green),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                                    child: Text(
                                                      "Save",
                                                      style: TextStyle(fontSize: 12, color: Colors.green),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () => state.toggleEdit(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: AppColors.primary),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(fontSize: 12, color: AppColors.primary),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        state.isEdit
                                            ? const SizedBox()
                                            : const Icon(Icons.bookmark_border_outlined, color: AppColors.primary)
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Text(
                                          "No Products",
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      state.foods.isNotEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width - 15,
                              height: 60 + (60.0 * state.foods.length),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: state.foods.length,
                                        itemBuilder: (context, i) {
                                          FoodItem item = state.foods[i];
                                          return _foodItemRow(context, item, i);
                                        },
                                      ),
                                    ),
                                    const Divider(thickness: 2, color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Total", style: TextStyle(color: Colors.green, fontSize: 16)),
                                          Row(
                                            children: [
                                              Text(
                                                "${state.totalCalories} Cal",
                                                style: const TextStyle(color: Colors.green, fontSize: 16),
                                              ),
                                              const SizedBox(width: 40),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _foodItemRow(BuildContext context, FoodItem item, int index) {
    final state = Provider.of<MealTileState>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  item.name,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "${item.cal} Cal",
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () => state.removeFoodItem(index),
                  icon: Icon(
                    state.isEdit ? Icons.cancel : Icons.arrow_circle_right_sharp,
                    size: 18,
                    color: state.isEdit ? Colors.red.withOpacity(0.7) : AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Divider(thickness: 2, color: Colors.white),
      ],
    );
  }
}
