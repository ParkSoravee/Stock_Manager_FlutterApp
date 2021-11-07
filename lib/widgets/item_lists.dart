import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/utils/item.dart';
import 'package:provider/provider.dart';

import 'item_list_tile.dart';

class ItemLists extends StatefulWidget {
  const ItemLists({Key? key}) : super(key: key);

  @override
  State<ItemLists> createState() => _ItemListsState();
}

class _ItemListsState extends State<ItemLists> {
  late final List<Item> items;

  @override
  void initState() {
    // fetch items
    items = Provider.of<WareHouses>(context, listen: false).fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ItemListTile(
              itemId: items[i].itemId,
              itemTitle: items[i].itemTitle,
              date: items[i].date,
            ),
          ),
        ),
      ),
    );
  }
}
