import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/models/menus.dart';
import 'package:users_app/widgets/app_bar.dart';
import 'package:users_app/widgets/items_design.dart';
import 'package:users_app/widgets/progress_bar.dart';
import 'package:users_app/widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;

  const ItemsScreen({Key? key, this.model}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
              title: 'Items 0f ' + widget.model!.menuTitle.toString(),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(widget.model!.sellerUID)
                  .collection('menus')
                  .doc(widget.model!.menuID)
                  .collection('items')
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
                          Items itemsModel = Items.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );

                          return ItemsDesignWidget(
                            model: itemsModel,
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
