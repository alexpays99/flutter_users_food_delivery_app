import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistantMethods/cart_item_counter.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  MyAppBar({Key? key, this.bottom}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 30 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'iFood',
          style: TextStyle(fontSize: 45, fontFamily: 'Signatra'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  //send user to cart screen
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 255, 248, 218),
                ),
              ),
              Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, child) {
                            return Text(
                              counter.count.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
