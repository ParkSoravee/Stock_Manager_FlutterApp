import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListTile extends StatelessWidget {
  final String itemId;
  final String itemTitle;
  final DateTime date;
  final String position;

  const ItemListTile({
    required this.itemId,
    required this.itemTitle,
    required this.date,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Container(
                  child: Text(
                    position,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('$itemTitle'),
                        subtitle: Text(
                          DateFormat(
                            'EEE dd/MM/yyyy HH:mm น.',
                          ).format(date),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    );
  }
}
