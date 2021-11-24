import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ENDPOINT = dotenv.env['ENDPOINT'];

class History {
  // ข้อมูลที่ได้รับจาก server
  final String id;
  final String itemId;
  final String itemTitle;
  final String description;
  final String status;
  final DateTime dateIn;
  final DateTime? dateOut;
  final DateTime date;

  History({
    required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.description,
    required this.status,
    required this.date,
    required this.dateIn,
    this.dateOut,
  });
}

class Histories with ChangeNotifier {
  List<History> _items = [
    // History(
    //   id: '1',
    //   itemId: '123456',
    //   itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
    //   status: 'add',
    //   dateIn: DateTime.parse('2021-11-05T16:36:40.818110'),
    // ),
    // History(
    //   id: '2',
    //   itemId: '234567',
    //   itemTitle: 'มะม่วงดองน้ำปลา',
    //   status: 'remove',
    //   dateIn: DateTime.parse('2021-11-04T16:37:40.818110'),
    //   dateOut: DateTime.parse('2021-11-04T18:37:40.818110'),
    // ),
  ];

  List<History> get items {
    return [..._items];
  }

  Future<void> fetchAndSetsHistories() async {
    var url = Uri.parse('$ENDPOINT/history');
    try {
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final historyList = extractedData['histories'];
      final List<History> loadedHistory = [];

      historyList.forEach((historyData) async {
        // print(historyData['id']);
        url = Uri.parse('$ENDPOINT/item/${historyData['id']}');
        final productInfoResponse = await http.get(url);
        final extractedProductData =
            json.decode(utf8.decode(productInfoResponse.bodyBytes))
                as Map<String, dynamic>;
        loadedHistory.add(
          History(
            id: historyData['id'],
            itemId: historyData['id'], // TODO change id
            itemTitle: extractedProductData['name'],
            description: extractedProductData['description'],
            status: historyData['action'],
            date: DateTime.parse(historyData['date']),
            dateIn: DateTime.parse(extractedProductData['date']),
            dateOut: DateTime.parse(extractedProductData['dateOut']),
          ),
        );
      });
      _items = loadedHistory;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
