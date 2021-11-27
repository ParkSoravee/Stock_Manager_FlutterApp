import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItemListTile extends StatelessWidget {
  final String itemId;
  final String itemTitle;
  final DateTime date;

  const HistoryItemListTile({
    required this.itemId,
    required this.itemTitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('$itemTitle'),
          subtitle: Text(
            // DateFormat(
            //       'EEE dd/MM/yyyy HH:mm น.',
            //     ).format(date) +
            '$itemId',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          trailing: Text(
            DateFormat(
              'dd/MM/yyyy\nHH:mm น.',
            ).format(date),
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
    );
  }
}
