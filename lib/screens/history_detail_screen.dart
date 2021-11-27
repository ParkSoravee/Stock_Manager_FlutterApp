import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryDetailScreen extends StatefulWidget {
  // final String itemId;
  final String historyId;
  const HistoryDetailScreen({
    // required this.itemId,
    required this.historyId,
  });

  @override
  _HistoryDetailScreenState createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  late final History loadedHistory;
  var _isLoading = true;

  @override
  void initState() {
    Provider.of<Histories>(context, listen: false)
        .fetchAndSetHistoryDetail(widget.historyId)
        .then((_) {
      setState(() {
        loadedHistory = Provider.of<Histories>(context, listen: false)
            .getById(widget.historyId);
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: MediaQuery.of(context).size.width * 10 / 100,
            ),
            child: Column(
              children: [
                Text(
                  loadedHistory.itemTitle,
                  style: const TextStyle(fontSize: 22),
                ),
                Text(loadedHistory.detail == null
                    ? 'barcode: -'
                    : 'barcode: ${loadedHistory.detail!.id}'),
                // Text('ID สินค้า: ${loadedHistory.itemId}'),
                ListTile(
                  leading: Text('ID สินค้า:'),
                  title: Text(loadedHistory.itemId),
                ),
                const Divider(),
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
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          loadedHistory.detail == null
                              ? '-'
                              : DateFormat(
                                  'dd/MM/yyyy HH:mm น.',
                                ).format(loadedHistory.detail!.dateIn),
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'วันออก',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          loadedHistory.detail == null
                              ? '-'
                              : loadedHistory.detail!.dateOut != null
                                  ? DateFormat(
                                      'dd/MM/yyyy HH:mm น.',
                                    ).format(loadedHistory.detail!.dateOut!)
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
                Text(
                  loadedHistory.detail == null
                      ? '-'
                      : loadedHistory.detail!.description,
                ),
              ],
            ),
          );
  }
}
