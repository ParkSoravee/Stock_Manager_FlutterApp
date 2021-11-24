import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
import 'package:flutter_stock_manager/widgets/shelf_list.dart';

class ZoneItem extends StatelessWidget {
  final String wareHouseName;
  final Zone zone;
  const ZoneItem({
    required this.wareHouseName,
    required this.zone,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MainDetailScreen(
              title: 'โซน ${zone.name}',
              backTitle: 'โกดัง $wareHouseName',
              showScreen: ShelfList(
                wareHouseName: wareHouseName,
                zoneName: zone.name,
              ),
              // showScreen: null,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.rectangle_stack,
              color: Theme.of(context).primaryColor,
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
                    title: Text('โซน ${zone.name}'),
                    trailing: Text('${zone.itemCount} items'),
                  ),
                  Divider(
                    height: 2,
                    thickness: 0.3,
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
