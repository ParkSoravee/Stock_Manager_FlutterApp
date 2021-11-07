import 'package:flutter/foundation.dart';

class HoldingItem {
  final String id;
  final String itemId;
  final String itemTitle;
  final DateTime date;

  HoldingItem({
    required this.id,
    required this.itemId,
    required this.itemTitle,
    required this.date,
  });
}

class HoldingItems with ChangeNotifier {
  final List<HoldingItem> _items = [
    HoldingItem(
      id: '1',
      itemId: '123456',
      itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
      date: DateTime.parse('2021-11-05T16:36:40.818110'),
    ),
    HoldingItem(
      id: '2',
      itemId: '234567',
      itemTitle: 'มะม่วงดองน้ำปลา',
      date: DateTime.parse('2021-11-04T16:37:40.818110'),
    ),
  ];

  List<HoldingItem> get items {
    return [..._items];
  }
}
