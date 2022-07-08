import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/gloval.dart';
import 'package:fluttertoast/fluttertoast.dart';

addItemToCart(String? foodItemId, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedPreferences!.getStringList('userCart');
  tempList!.add(foodItemId! + ':$itemCounter'); //527123123:3

  FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    'userCart': tempList,
  }).then((value) {
    Fluttertoast.showToast(
      msg: "Item Added Successfully!",
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      // timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0,
    );

    sharedPreferences!.setStringList('userCart', tempList);

    //update the badge
  });
}
