import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/global/gloval.dart';
import 'package:users_app/models/menus.dart';
import 'package:users_app/models/sellers.dart';
import 'package:users_app/widgets/menus_design.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/progress_bar.dart';
import 'package:users_app/widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;

  const MenusScreen({Key? key, this.model}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text(
          'iFood',
          style: TextStyle(fontSize: 45, fontFamily: 'Signatra'),
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
                title: widget.model!.sellerName.toString() + 'My Menus'),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(widget.model!.sellerUID)
                  .collection('menus')
                  .orderBy('publishedDate', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: circularProgress(),
                      )
                    : StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Menus menuModel = Menus.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );

                          return MenusDesignWidget(
                            model: menuModel,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
