import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:intl/intl.dart';

class HistoryDetailScreen extends StatelessWidget {
  final History historyItems;
  const HistoryDetailScreen({Key? key, required this.historyItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: MediaQuery.of(context).size.width * 15 / 100,
      ),
      child: Column(
        children: [
          Text(
            historyItems.itemTitle,
            style: const TextStyle(fontSize: 22),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('ID: ${historyItems.id}'),
              Text('ID สินค้า: ${historyItems.itemId}'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'วันเข้า',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat(
                      'dd/MM/yyyy HH:mm น.',
                    ).format(historyItems.dateIn),
                    style: const TextStyle(fontSize: 13),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'วันออก',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    historyItems.dateOut != null
                        ? DateFormat(
                            'dd/MM/yyyy HH:mm น.',
                          ).format(historyItems.dateOut!)
                        : '--/--/---- --:-- น.',
                    style: const TextStyle(fontSize: 13),
                  )
                ],
              ),
            ],
          ),
          const Divider(
            height: 25,
          ),
          const Text('description...')
        ],
      ),
    );
  }
}
