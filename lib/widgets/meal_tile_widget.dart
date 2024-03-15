import 'package:flutter/material.dart';
import 'package:task/utilities/colors.dart';

import '../models/food_model.dart';

class MealTile extends StatefulWidget {
  final IconData icon;
  final String mealNo; 
  const MealTile({super.key, required this.icon, required this.mealNo});

  @override
  State<MealTile> createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  int _index = 0;
  bool _isEdit = false;
  List<FoodItem> foods = [];
  final List<FoodItem> _preSetItems = [
    FoodItem(name: "Spicy Bacon Cheese Toast", cal: 321),
    FoodItem(name: "Almond Milk", cal: 120),
    FoodItem(name: "Grill Cheese", cal: 220),
    FoodItem(name: "Bacon and Egg Sanwich", cal: 520)
  ];

  void _addItem(){
    if(_index<=3){
      setState(() {
      foods.add(_preSetItems[_index]);
      _index++;
    });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomPaint(
        painter: CurvedCornerPainter(),
        child: Stack(children: [
          Positioned(
              right: 0,
              child: InkWell(
                splashColor: Colors.white,
                onTap: _addItem,
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20))
                  ),
                  child: const Icon(Icons.add, color: Colors.white,),
                ),
              ) ),
          Container(
            width: double.infinity,
            height: foods.isNotEmpty? 160+(foods.length*43):110,
            padding: const EdgeInsets.all(08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Icon(widget.icon, color: AppColors.primary,),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Meal ${widget.mealNo}', 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        foods.isNotEmpty?
                         Row(
                          children: [
                          _isEdit? 
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _isEdit = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.green)
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text("Save",style: TextStyle(fontSize: 12, color: Colors.green),),
                                )),
                            )
                          : 
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _isEdit = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text("Edit",style: TextStyle(fontSize: 12, color: Colors.white),),
                                )),
                            ),
                            _isEdit? const SizedBox() : const Icon(Icons.bookmark_border_outlined, color: Colors.grey,)
                          ],
                        )
                        :
                        Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text("No Products",style: TextStyle(fontSize: 12, color: Colors.white),),
                              )),
                      ],
                    ),

                  ],
                ),
                const SizedBox(height: 10,),
                      foods.isNotEmpty? Container(
                          width: size.width-15,
                          height: 60+(43.0*foods.length),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child:  
                                  ListView.builder(
                                    itemCount: foods.length,
                                    itemBuilder:(context, i){
                                      FoodItem item = foods[i];
                                      return foodItemRow(item, i);}
                                  )
                                ),
                                const Divider(thickness: 2,color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total",style: TextStyle(color: Colors.green),),
                                      Text("${foods.fold(0, (total, item) => total + item.cal)} Cal",style: const TextStyle(color: Colors.green),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ):const SizedBox(),
                ],
            ),
          ),
        ]),
      ),
    );
  }

  Row foodItemRow(FoodItem item, int i) {
                           return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.name, style: const TextStyle(color: Colors.grey),),
                                      Row(
                                        children: [
                                          Text("${item.cal} Cal"),
                                          IconButton(onPressed: (){
                                            if(_isEdit){
                                              setState(() {
                                                foods.removeAt(i);
                                                _index--;
                                              });
                                            }
                                          }, icon: Icon( _isEdit? Icons.cancel :Icons.arrow_circle_right_sharp, color: _isEdit? Colors.red :AppColors.primary,))
                                        ],
                                      ),
                                    ],
                                  );
  }
}

class CurvedCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const double radius = 20;
    var path = Path()
    
      ..moveTo(radius, 0)
      ..lineTo(size.width - 81, 0)
      ..quadraticBezierTo(
        size.width - 80, 00,
        size.width - 80, 80,
      )
      ..quadraticBezierTo(
        size.width - 80, 80,
        size.width, 80,
      )
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(size.width, size.height, size.width - radius, size.height)
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..close();

    canvas.drawShadow(path, Colors.black, 3.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
