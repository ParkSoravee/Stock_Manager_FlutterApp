import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_stock_manager/utils/item.dart';

final ENDPOINT = dotenv.env['ENDPOINT'];

class WareHouse {
  final String name;
  final List<Zone> zone;

  WareHouse({
    required this.name,
    required this.zone,
  });
}

class Zone {
  final String name;
  final int itemCount;

  Zone({
    required this.name,
    required this.itemCount,
  });
}

class Shelf {
  final String name;
  final int itemCount;

  Shelf({
    required this.name,
    required this.itemCount,
  });
}

class WareHouses with ChangeNotifier {
  List<WareHouse> _warehouseItems = [
    // WareHouse('1', [2, 3]),
    // WareHouse('2', [13, 9]),
  ];

  List<Zone> _zoneItems = [];

  List<Shelf> _shelfItems = [
    // Shelf(
    //   name: '1',
    //   itemCount: 0,
    // ),
    // Shelf(
    //   name: '2',
    //   itemCount: 0,
    // )
  ];

  List<Item> _items = [];

  List<WareHouse> get warehouses {
    return [..._warehouseItems];
  }

  List<Shelf> get shelfs {
    return [..._shelfItems];
  }

  List<Item> get items {
    return [..._items];
  }

  Future<void> fetchWareHouses() async {
    print('fetch warehouse');
    try {
      var url = Uri.parse('$ENDPOINT/warehouse');
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final wareHouseList = extractedData['warehouses'] as List<dynamic>;
      final List<WareHouse> _loadedWarehouses = [];
      // print(wareHouseList);

      wareHouseList.forEach((warehouseData) {
        List<Zone> _zones = [];
        warehouseData['zone'].forEach((zone) {
          _zones.add(Zone(
            name: zone['name'],
            itemCount: zone['item'],
          ));
        });

        _loadedWarehouses.add(
          WareHouse(
            name: warehouseData['warehouse'],
            zone: _zones,
          ),
        );
      });
      _warehouseItems = _loadedWarehouses;
    } catch (error) {}
  }

  Future<void> fetchShelfs(String warehouse, String zone) async {
    try {
      print('fetch shelfs');
      var url = Uri.parse('$ENDPOINT/warehouse/$warehouse/zone/$zone');
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final shelfList = extractedData['shelfs'] as List<dynamic>;
      final List<Shelf> _loadedShelfs = [];
      // print(wareHouseList);

      shelfList.forEach((shelfData) {
        _loadedShelfs.add(
          Shelf(name: shelfData['shelf'], itemCount: shelfData['item']),
        );
      });
      _shelfItems = _loadedShelfs;
      print('finished');
    } catch (error) {}
  }

  Future<void> fetchItems() async {
    print('fetch items');
    // return [
    //   Item(
    //     id: '1',
    //     itemId: '123456',
    //     itemTitle: 'ยาสีฟันแปรงไม่สะอาด',
    //     date: DateTime.parse('2021-11-05T16:36:40.818110'),
    //   ),
    //   Item(
    //     id: '2',
    //     itemId: '234567',
    //     itemTitle: 'มะม่วงดองน้ำปลา',
    //     date: DateTime.parse('2021-11-04T16:37:40.818110'),
    //   ),
    // ];
  }
}
