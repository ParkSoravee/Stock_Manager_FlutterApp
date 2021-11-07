import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/widgets/item_list_tile.dart';
import 'package:provider/provider.dart';

class HoldingList extends StatefulWidget {
  const HoldingList({Key? key}) : super(key: key);

  @override
  _HoldingListState createState() => _HoldingListState();
}

class _HoldingListState extends State<HoldingList> {
  @override
  Widget build(BuildContext context) {
    final loadedHoldingItem = Provider.of<HoldingItems>(context).items;
    return Expanded(
      child: ListView.builder(
        itemCount: loadedHoldingItem.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ItemListTile(
                itemId: loadedHoldingItem[i].itemId,
                itemTitle: loadedHoldingItem[i].itemTitle,
                date: loadedHoldingItem[i].date,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
