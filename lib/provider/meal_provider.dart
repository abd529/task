import 'package:flutter/material.dart';

import '../models/food_model.dart';

class MealTileState with ChangeNotifier {
  int _index = 0;
  bool _isEdit = false;
  final List<FoodItem> _foods = [];
  final List<FoodItem> _preSetItems = [
    FoodItem(name: "Spicy Bacon Cheese Toast", cal: 321),
    FoodItem(name: "Almond Milk", cal: 120),
    FoodItem(name: "Grill Cheese", cal: 220),
    FoodItem(name: "Bacon and Egg Sandwich", cal: 520),
  ];

  List<FoodItem> get foods => _foods;
  bool get isEdit => _isEdit;
  int get totalCalories => _foods.fold(0, (total, item) => total + item.cal);

  void addItem() {
    if (_index <= 3) {
      _foods.add(_preSetItems[_index]);
      _index++;
      notifyListeners();
    }
  }

  void toggleEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }

  void removeFoodItem(int index) {
    if (_isEdit) {
      _foods.removeAt(index);
      _index--;
      notifyListeners();
    }
  }
}