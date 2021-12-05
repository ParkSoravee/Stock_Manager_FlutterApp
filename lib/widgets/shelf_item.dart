import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';

import 'item_lists.dart';

class ShelfItem extends StatelessWidget {
  final String wareHouseName;
  final String zoneName;
  final Shelf shelfItem;
  const ShelfItem({
    required this.wareHouseName,
    required this.zoneName,
    required this.shelfItem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MainDetailScreen(
              path:
                  'warehouse${wareHouseName}/zone${zoneName}/shelf${shelfItem.name}',
              title: 'ชั้นวาง ${shelfItem.name}',
              backTitle: 'โซน $zoneName',
              showScreen: ItemLists(
                wareHouseName: wareHouseName,
                zoneName: zoneName,
                shelfName: shelfItem.name,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.rectangle_stack,
              color: Theme.of(context).primaryColor,
              size: 33,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text('ชั้นวาง ${shelfItem.name}'),
                    subtitle: Text('${shelfItem.itemCount} items'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  Divider(
                    height: 2,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
