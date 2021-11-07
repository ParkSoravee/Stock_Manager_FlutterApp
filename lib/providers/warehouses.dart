import 'package:flutter/cupertino.dart';
import 'package:flutter_stock_manager/utils/item.dart';

class WareHouse {
  final String id;
  final List<int> floor;

  WareHouse(this.id, this.floor);
}

class Zone {
  final String id;
  final int itemCount;

  Zone(this.id, this.itemCount);
}

class WareHouses with ChangeNotifier {
  final List<WareHouse> _items = [
    WareHouse('1', [2, 3]),
    WareHouse('2', [13, 9]),
  ];

  List<WareHouse> get items {
    return [..._items];
  }

  void fetchWareHouse() {
    print('fetch warehouse');
  }

  List<Zone> fetchZones() {
    print('fetch zone');
    return [
      Zone('A', 5),
      Zone('B', 10),
    ];
  }

  List<Item> fetchItems() {
    print('fetch items');
    return [
      Item(
        id: '1',
        itemId: '123456',
        itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
        date: DateTime.parse('2021-11-05T16:36:40.818110'),
      ),
      Item(
        id: '2',
        itemId: '234567',
        itemTitle: 'มะม่วงดองน้ำปลา',
        date: DateTime.parse('2021-11-04T16:37:40.818110'),
      ),
    ];
  }
}
