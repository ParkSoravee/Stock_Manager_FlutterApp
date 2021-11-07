import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:flutter_stock_manager/screens/history_detail_screen.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
import 'package:intl/intl.dart';

import 'item_list_tile.dart';

class HistoryListTile extends StatelessWidget {
  final History historyItems;
  const HistoryListTile(this.historyItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MainDetailScreen(
              title: 'รายละเอียด',
              backTitle: 'ประวัติ',
              showScreen: HistoryDetailScreen(
                historyItems: historyItems,
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  historyItems.status == 'add' ? Icons.add : Icons.remove,
                  size: 30,
                  color:
                      historyItems.status == 'add' ? Colors.green : Colors.red,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ItemListTile(
                        itemId: historyItems.itemId,
                        itemTitle: historyItems.itemTitle,
                        date: historyItems.dateIn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
