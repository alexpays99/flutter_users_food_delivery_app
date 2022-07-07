import 'package:flutter/material.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/widgets/app_bar.dart';

class ItemDetailScreen extends StatefulWidget {
  final Items? model;
  const ItemDetailScreen({Key? key, this.model}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
    );
  }
}
