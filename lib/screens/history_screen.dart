import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:flutter_stock_manager/widgets/history_list_tile.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    Provider.of<Histories>(context, listen: false).fetchHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadedHistoryItem =
        Provider.of<Histories>(context, listen: false).items;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: loadedHistoryItem.length,
            itemBuilder: (ctx, i) => HistoryListTile(loadedHistoryItem[i]),
          ),
        )
      ],
    );
  }
}
