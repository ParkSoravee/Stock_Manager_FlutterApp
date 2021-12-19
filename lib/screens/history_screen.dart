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
  var _isLoading = true;
  var _isDispose = false;
  late final loadedHistoryItem;
  @override
  void initState() {
    Provider.of<Histories>(context, listen: false)
        .fetchAndSetsHistories()
        .then((_) {
      if (!_isDispose) {
        setState(() {
          loadedHistoryItem =
              Provider.of<Histories>(context, listen: false).items;
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: loadedHistoryItem.length,
                  itemBuilder: (ctx, i) =>
                      HistoryListTile(loadedHistoryItem[i]),
                ),
              )
            ],
          );
  }
}
