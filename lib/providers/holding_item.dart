import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_stock_manager/models/item_location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HoldingItem {
  // final String id;
  final String itemId;
  final String itemTitle;
  final DateTime date;

  HoldingItem({
    // required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.date,
  });
}

class HoldingItems with ChangeNotifier {
  final ENDPOINT = dotenv.env['ENDPOINT'];

  List<HoldingItem> _items = [
    // HoldingItem(
    //   id: '1',
    //   itemId: '123456',
    //   itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
    //   date: DateTime.parse('2021-11-05T16:36:40.818110'),
    // ),
    // HoldingItem(
    //   id: '2',
    //   itemId: '234567',
    //   itemTitle: 'มะม่วงดองน้ำปลา',
    //   date: DateTime.parse('2021-11-04T16:37:40.818110'),
    // ),
  ];

  List<HoldingItem> get items {
    return [..._items];
  }

  Future<void> fetchAndSetHoldingItem() async {
    try {
      print('fetch holding item');
      var url = Uri.parse('$ENDPOINT/holding-items');
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final itemsList = extractedData['holdingItems'] as List<dynamic>;
      final List<HoldingItem> _loadedItems = [];
      // print(wareHouseList);

      itemsList.forEach((itemData) {
        _loadedItems.add(
          HoldingItem(
            // id: itemData['id'],
            itemId: itemData['id'],
            itemTitle: itemData['name'],
            date: DateTime.parse(itemData['date']),
          ),
        );
      });
      _items = _loadedItems;
      // notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addHoldingItem(String barcode) async {
    try {
      print('add holding item');
      print(barcode);
      var url = Uri.parse('$ENDPOINT/holding-items');
      final barcodeList = [barcode];
      final body = json.encode({
        "barcodeList": barcodeList,
      });
      // print(body);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.body);
      final extracted = json.decode(response.body);
      if (extracted['isImported'] == false) throw 'error';
      await fetchAndSetHoldingItem();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addItem({
    required String itemId,
    required String itemName,
    required ItemLocation itemLocation,
  }) async {
    // save var
    final _saveIndex = _items.indexWhere((item) => item.itemId == itemId);
    final _saveItem = _items[_saveIndex];
    try {
      // print(itemId);
      // print(itemLocation.path);
      // print(itemLocation.slot);
      // delete
      _items.removeWhere((item) => item.itemId == itemId);
      // add item
      var url = Uri.parse('$ENDPOINT/item');
      final body = json.encode({
        "id": itemId,
        "path": itemLocation.path,
        "location": itemLocation.slot,
        "name": itemName,
      });
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      // print(response.body);
      final extracted = json.decode(response.body);
      if (extracted['IsInserted'] == false) throw 'error';
      notifyListeners();
    } catch (error) {
      _items.insert(_saveIndex, _saveItem);
      throw error;
    }
  }

  Future<void> removeItem({
    required String itemId,
    required String path,
  }) async {
    var url = Uri.parse('$ENDPOINT/item');
    final body = json.encode({
      "itemIdList": [itemId],
      "path": path,
    });
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.body);
    final extracted = json.decode(response.body);
    if (extracted['isDeleted'] == false) throw 'error';
  }

  HoldingItem findByItemId(String id) {
    try {
      return _items.firstWhere((item) => item.itemId == id);
    } catch (error) {
      throw error;
    }
  }
}
