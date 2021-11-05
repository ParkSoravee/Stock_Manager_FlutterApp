import 'package:flutter/foundation.dart';

class History {
  // ข้อมูลที่ได้รับจาก server
  final String id;
  final String itemId;
  final String itemTitle;
  final String status;
  final DateTime date;

  History({
    required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.status,
    required this.date,
  });
}

class Histories with ChangeNotifier {
  final List<History> _items = [
    History(
      id: '1',
      itemId: '123456',
      itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
      status: 'add',
      date: DateTime.parse('2021-11-05T16:36:40.818110'),
    ),
    History(
      id: '2',
      itemId: '234567',
      itemTitle: 'มะม่วงดองน้ำปลา',
      status: 'remove',
      date: DateTime.parse('2021-11-04T16:37:40.818110'),
    ),
  ];

  List<History> get items {
    return [..._items];
  }

  void fetchHistory() {
    print('fetch history');
  }
}
