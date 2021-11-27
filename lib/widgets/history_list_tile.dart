import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:flutter_stock_manager/screens/history_detail_screen.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
import 'package:intl/intl.dart';

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
                // itemId: historyItems.itemId,
                historyId: historyItems.id,
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
                  historyItems.status == 'insert' ? Icons.add : Icons.remove,
                  size: 30,
                  color: historyItems.status == 'insert'
                      ? Colors.green
                      : Colors.red,
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(historyItems.itemTitle),
                        subtitle: Text(
                          historyItems.itemId,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        trailing: Text(
                          DateFormat(
                            'dd/MM/yyyy\nHH:mm น.',
                          ).format(historyItems.date),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        indent: 15,
                        endIndent: 15,
                        thickness: 0.6,
                        color: Theme.of(context).colorScheme.secondary,
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
