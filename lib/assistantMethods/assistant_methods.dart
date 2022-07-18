import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/gloval.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// separates foodItemIDs from the userCart list and returns new list of foodItemIDs
separateItemIDs() {
  List<String> separateItemIDsList = [], defaultItemList;
  int i = 0;

  defaultItemList = sharedPreferences!.getStringList('userCart')!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString(); //527123123:3
    var pos = item.lastIndexOf(':');
    String getItemId = (pos != -1) ? item.substring(0, pos) : item; //527123123

    print('\nThis is itemID now = ' + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print('\nThis is itemID now = ');
  print(separateItemIDsList);

  return separateItemIDsList;
}

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
