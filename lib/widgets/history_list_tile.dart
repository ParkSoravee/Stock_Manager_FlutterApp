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
                      ListTile(
                        title: Text(
                            '${historyItems.itemId} - ${historyItems.itemTitle}'),
                        subtitle: Text(
                          DateFormat(
                            'EEE dd/MM/yyyy HH:mm น.',
                          ).format(historyItems.dateIn),
                        ),
                      ),
                      const Divider(
                        height: 3,
                        indent: 15,
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
