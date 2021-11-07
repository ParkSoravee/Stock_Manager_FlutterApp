import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListTile extends StatelessWidget {
  final String itemId;
  final String itemTitle;
  final DateTime date;

  const ItemListTile({
    Key? key,
    required this.itemId,
    required this.itemTitle,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('$itemId - $itemTitle'),
          subtitle: Text(
            DateFormat(
              'EEE dd/MM/yyyy HH:mm น.',
            ).format(date),
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
