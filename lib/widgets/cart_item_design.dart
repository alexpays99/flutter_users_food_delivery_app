import 'package:flutter/material.dart';
import 'package:users_app/models/items.dart';

class CartItemDesisgn extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final List<int>? separateItemQuantityList;

  CartItemDesisgn({
    Key? key,
    this.model,
    this.context,
    this.separateItemQuantityList,
  }) : super(key: key);

  @override
  State<CartItemDesisgn> createState() => _CartItemDesisgnState();
}

class _CartItemDesisgnState extends State<CartItemDesisgn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 165,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(
                widget.model!.thumbnailUrl!,
                width: 140,
                height: 120,
              ),
              const SizedBox(width: 6),
              //title
              //quantity number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Kiwi',
                    ),
                  ),
                  const SizedBox(height: 1),
                  //x 7
                  Row(
                    children: [
                      const Text(
                        'x ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Acme',
                        ),
                      ),
                      Text(
                        widget.separateItemQuantityList.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  //price
                  Row(
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: 'Acme',
                        ),
                      ),
                      const Text(
                        '\$ ',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 25,
                          fontFamily: 'Acme',
                        ),
                      ),
                      Text(
                        widget.model!.price!.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
