import 'package:flutter/foundation.dart';
import 'package:users_app/global/gloval.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListitemCounter =
      sharedPreferences!.getStringList('userCart')!.length - 1;

  int get count => cartListitemCounter;

  Future<void> displayCartListItemsNumber() async {
    cartListitemCounter =
        sharedPreferences!.getStringList('userCart')!.length - 1;

    await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
