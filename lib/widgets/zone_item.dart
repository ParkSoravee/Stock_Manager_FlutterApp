import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';

import 'item_lists.dart';

class ZoneItem extends StatelessWidget {
  final Zone zone;
  final int floor;
  const ZoneItem(this.floor, this.zone, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MainDetailScreen(
              title: 'โซน ${zone.id}',
              backTitle: 'ชั้น $floor',
              showScreen: ItemLists(),
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
                    title: Text('โซน ${zone.id}'),
                    subtitle: Text('${zone.itemCount} items'),
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
