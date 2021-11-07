import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
import 'package:flutter_stock_manager/widgets/zone_lists.dart';

class FloorItem extends StatelessWidget {
  final int floor;
  final String wareHouseId;
  final int itemCount;
  const FloorItem(this.floor, this.wareHouseId, this.itemCount, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MainDetailScreen(
              title: 'ชั้น ${floor + 1}',
              backTitle: 'โกดัง $wareHouseId',
              showScreen: ZoneLists(floor + 1),
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
                    title: Text('ชั้น ${floor + 1}'),
                    trailing: Text('$itemCount items'),
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
