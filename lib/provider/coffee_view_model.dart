import 'package:flutter/material.dart';
import 'package:paguyuban/models/coffee.dart';
import 'package:paguyuban/others/colors.dart';

class CoffeeViewModel extends ChangeNotifier {
  TabController? tabController;
  String _sizeSelected = 'S'; // Default size

  String get sizeSelected => _sizeSelected;

  Coffee? detailCoffee;
  bool? isChecked = true;
  List<Coffee> coffees = [
    Coffee(
      name: 'Kopi Hitam',
      imageUrl: "assets/coffee_mart/coffee1.jpeg",
      price: 10000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Susu',
      imageUrl: "assets/coffee_mart/coffee2.jpeg",
      price: 12000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Cappuccino',
      imageUrl: "assets/coffee_mart/coffee3.jpeg",
      price: 15000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Arabica',
      imageUrl: "assets/coffee_mart/coffee4.jpeg",
      price: 18000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Robusta',
      imageUrl: "assets/coffee_mart/coffee5.jpeg",
      price: 15000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Espresso',
      imageUrl: "assets/coffee_mart/coffee6.jpeg",
      price: 20000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Mocha',
      imageUrl: "assets/coffee_mart/coffee7.jpeg",
      price: 18000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Latte',
      imageUrl: "assets/coffee_mart/coffee8.jpeg",
      price: 16000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Caramel',
      imageUrl: "assets/coffee_mart/coffee9.jpeg",
      price: 19000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
    Coffee(
      name: 'Kopi Vanilla',
      imageUrl: "assets/coffee_mart/coffee10.jpeg",
      price: 17000,
      rate: 4.8,
      review: 250,
      type: 'espreso',
      description:
          'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo',
    ),
  ];

  checkbox() {
    return Checkbox(
        tristate: true,
        value: isChecked,
        onChanged: (bool? value) {
          () {
            isChecked = value;
          };
        });
  }

  getDetailCoffee(Coffee coffee) {
    detailCoffee = coffee;
    notifyListeners();
  }

  tapbarCoffee(context) {
    return TabBar(
      controller: tabController,
      labelColor: ColorLibrary.primary,
      unselectedLabelColor: Colors.white.withOpacity(0.5),
      isScrollable: true,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3,
            color: ColorLibrary.primary,
          ),
          insets: EdgeInsets.symmetric(horizontal: 10)),
      tabs: [
        Tab(
          text: "Hot Coffee",
        ),
        Tab(
          text: "Hot Coffee",
        ),
        Tab(
          text: "Hot Coffee",
        ),
        Tab(
          text: "Hot Coffee",
        ),
      ],
    );
  }

  void selectSize(String size) {
    _sizeSelected = size;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  sizeCoffee() {
    return Row(
      children: ['S', '', 'M', '', 'L'].map((e) {
        if (e == '') {
          return const SizedBox(
            width: 16,
          );
        }

        bool isSelected = _sizeSelected == e;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              selectSize(e); // Update selected size
            },
            child: Container(
              height: 41,
              decoration: BoxDecoration(
                color:
                    isSelected ? ColorLibrary.thirdDark : ColorLibrary.shadow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? ColorLibrary.shadow : ColorLibrary.primary,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                e,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color:
                      isSelected ? ColorLibrary.shadow : ColorLibrary.primary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
