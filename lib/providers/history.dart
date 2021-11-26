import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ENDPOINT = dotenv.env['ENDPOINT'];

// TODO : HistoryDetail
class History {
  // ข้อมูลที่ได้รับจาก server
  final String id;
  final String itemId;
  final String itemTitle;
  final String status;
  final DateTime date;

  HistoryDetail? detail;

  History({
    required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.status,
    required this.date,
    this.detail,
  });

  void updateDetail(HistoryDetail loadDetail) {
    detail = loadDetail;
  }
}

class HistoryDetail {
  final String id;
  final DateTime dateIn;
  final DateTime? dateOut;
  final String description;

  HistoryDetail({
    required this.id,
    required this.description,
    required this.dateIn,
    this.dateOut,
  });
}

class Histories with ChangeNotifier {
  List<History> _items = [];

  List<History> get items {
    return [..._items];
  }

  Future<void> fetchAndSetsHistories() async {
    var url = Uri.parse('$ENDPOINT/history');
    try {
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final historyList = extractedData['histories'] as List<dynamic>;
      List<History> _loadedHistory = [];

      historyList.forEach((historyData) {
        _loadedHistory.add(History(
          id: historyData['id'],
          itemId: historyData['itemId'],
          itemTitle: historyData['name'],
          status: historyData['action'],
          date: DateTime.parse(historyData['date']),
        ));
      });

      _items = _loadedHistory;
      // print(_loadedHistory);
      // notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetHistoryDetail(String itemId) async {
    try {
      print(itemId);
      var url = Uri.parse('$ENDPOINT/item/$itemId');
      final productDetailResponse = await http.get(url);
      final extractedProductDetail =
          json.decode(utf8.decode(productDetailResponse.bodyBytes))
              as Map<String, dynamic>;
      print(extractedProductDetail);
      // ! Debug
      print(productDetailResponse.body);
      print(extractedProductDetail['barcode']);

      final _historyIndex = _items.indexWhere((item) => item.itemId == itemId);
      _items[_historyIndex].updateDetail(HistoryDetail(
        id: extractedProductDetail['barcode'],
        description: extractedProductDetail['description'],
        dateIn: DateTime.parse(extractedProductDetail['date']),
        dateOut: extractedProductDetail['dateOut'] == null
            ? null
            : DateTime.parse(extractedProductDetail['dateOut']),
      ));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  History getById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
