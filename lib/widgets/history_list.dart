import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:flutter_stock_manager/widgets/history_list_tile.dart';

enum HistoryStatus {
  all,
  import,
  export,
}

class HistoryList extends StatefulWidget {
  // final bool isLoading;
  final List<History> loadedHistoryItem;
  HistoryList(
    // required this.isLoading,
    this.loadedHistoryItem,
  );

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text('ทั้งหมด'),
              ),
              Tab(
                child: Text('เพิ่มเข้า'),
              ),
              Tab(
                child: Text('นำออก'),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Expanded(
            child: TabBarView(children: [
              historyList(HistoryStatus.all),
              historyList(HistoryStatus.import),
              historyList(HistoryStatus.export),
            ]),
          )
        ],
      ),
    );
  }

  Widget historyList(HistoryStatus status) {
    List<History> historyItems = widget.loadedHistoryItem;
    if (status == HistoryStatus.import) {
      historyItems =
          historyItems.where((item) => item.status == 'insert').toList();
    } else if (status == HistoryStatus.export) {
      historyItems =
          historyItems.where((item) => item.status == 'export').toList();
    }
    return historyItems.length < 1
        ? Center(
            child: Text('No result'),
          )
        : ListView.builder(
            itemCount: historyItems.length,
            itemBuilder: (ctx, i) => HistoryListTile(historyItems[i]),
          );
  }
}
