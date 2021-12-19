import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/item.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:flutter_stock_manager/screens/detail_screen.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
import 'package:flutter_stock_manager/widgets/history_list.dart';
import 'package:flutter_stock_manager/widgets/history_list_tile.dart';
import 'package:flutter_stock_manager/widgets/item_list_tile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ENDPOINT = dotenv.env['ENDPOINT'];

class SearchItem with ChangeNotifier {
  Future<Widget> historySearch(String pattern) async {
    try {
      final List<History> loadedHistoryItem;
      Uri url;
      if (pattern.startsWith('date:') && pattern.length == 26) {
        final dateRange = pattern.replaceFirst('date:', '').split('-');
        final preDate =
            DateTime.parse(dateRange[0].trim().replaceAll('/', '-'));
        final postDate =
            DateTime.parse(dateRange[1].trim().replaceAll('/', '-'))
                .add(Duration(hours: 23, minutes: 59, seconds: 59));
        final preDateStr = preDate.toIso8601String();
        final postDateStr = postDate.toIso8601String();
        if (preDate.isAfter(postDate)) {
          throw Exception('date range in valid');
        }
        url = Uri.parse(
            '$ENDPOINT/history/search?preDate=$preDateStr&postDate=$postDateStr');
        // print('$ENDPOINT/history/search?preDate=$preDateStr&postDate=$postDateStr');
      } else {
        url = Uri.parse('$ENDPOINT/history/search?pattern=$pattern');
      }
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final historyList = extractedData['searchedResults'] as List<dynamic>;
      List<History> _loadedHistory = [];
      // print('search!!!');
      historyList.forEach((historyData) {
        _loadedHistory.add(History(
          id: historyData['id'],
          itemId: historyData['itemId'],
          itemTitle: historyData['name'],
          status: historyData['action'],
          date: DateTime.parse(historyData['date']),
        ));
      });
      // print(historyList);
      loadedHistoryItem = _loadedHistory;
      // return loadedHistoryItem.length < 1
      //     ? Center(
      //         child: Text('No result'),
      //       )
      //     : Column(
      //         children: [
      //           Expanded(
      //             child: ListView.builder(
      //               itemCount: loadedHistoryItem.length,
      //               itemBuilder: (ctx, i) =>
      //                   HistoryListTile(loadedHistoryItem[i]),
      //             ),
      //           )
      //         ],
      //       );
      return HistoryList(loadedHistoryItem);
    } catch (error) {
      print(error);
      // throw error;
      return Center(
        child: Text('No result (error)'),
      );
    }
  }

  Future<Widget> itemSearch(
      String pattern, String path, BuildContext context) async {
    try {
      final List<Item> _items;
      final queryParameters = {
        'pattern': pattern,
        'path': path,
      };
      final url = Uri.parse('$ENDPOINT/search?path=$path&pattern=$pattern');
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final itemList = extractedData['searchedResults'] as List<dynamic>;
      final List<Item> _loadedItems = [];

      itemList.forEach((itemData) {
        _loadedItems.add(
          Item(
            itemId: itemData['id'],
            itemTitle: itemData['name'],
            dateIn: DateTime.parse(itemData['date']),
            slot: itemData['location'],
          ),
        );
      });
      _items = _loadedItems;

      return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, i) => InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MainDetailScreen(
                  path: path,
                  title: 'รายละเอียด',
                  // backTitle: 'ชั้นวาง ${widget.shelfName}',
                  backTitle: 'ค้นหา',
                  showScreen: DetailScreen(
                    itemId: _items[i].itemId,
                  ),
                ),
              ),
            );
          },
          child: ItemListTile(
            position: _items[i].slot!,
            itemId: _items[i].itemId,
            itemTitle: _items[i].itemTitle,
            date: _items[i].dateIn,
          ),
        ),
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
