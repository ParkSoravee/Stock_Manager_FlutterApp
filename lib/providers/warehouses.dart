import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_stock_manager/models/item.dart';

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
  List<WareHouse> _warehouseItems = [];

  List<Zone> _zoneItems = [];

  List<Shelf> _shelfItems = [];

  List<Item> _items = [
    // Item(
    //   id: '1111',
    //   itemId: '123123',
    //   itemTitle: 'test',
    //   date: DateTime.now(),
    //   position: '1-A',
    // ),
  ];

  List<WareHouse> get warehouses {
    return [..._warehouseItems];
  }

  List<Shelf> get shelfs {
    return [..._shelfItems];
  }

  List<Item> get items {
    return [..._items];
  }

  Future<bool> fetchWareHouses() async {
    // print('fetch warehouse');
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
      return true;
    } catch (error) {
      print(error);
      return false;
    }
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchItems(String warehouse, String zone, String shelf) async {
    try {
      print('fetch shelfs');
      var url =
          Uri.parse('$ENDPOINT/warehouse/$warehouse/zone/$zone/shelf/$shelf');
      final response = await http.get(url);
      final extractedData = (json.decode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>);
      final itemList = extractedData['items'] as List<dynamic>;
      final List<Item> _loadedItems = [];
      // print(wareHouseList);

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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Item> fetchItemDetail(String itemId) async {
    print('fetch items details');
    try {
      var url = Uri.parse('$ENDPOINT/item/$itemId');
      final productDetailResponse = await http.get(url);
      final extractedProductDetail =
          json.decode(utf8.decode(productDetailResponse.bodyBytes))
              as Map<String, dynamic>;
      return Item(
        itemId: itemId,
        barcode: extractedProductDetail['barcode'],
        itemTitle: extractedProductDetail['name'],
        dateIn: DateTime.parse(extractedProductDetail['date']),
        dateOut: extractedProductDetail['dateOut'] == null
            ? null
            : DateTime.parse(extractedProductDetail['dateOut']),
        slot: extractedProductDetail['location'],
        path: extractedProductDetail['path'],
        description: extractedProductDetail['description'],
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  String? _defineType(String path) {
    if (path.contains('shelf')) {
      return null;
    } else if (path.contains('zone')) {
      return 'shelf';
    } else if (path.contains('warehouse')) {
      return 'zone';
    } else if (path == '') {
      return 'warehouse';
    }
    return null;
  }

  String? _defineName(String type, String path) {
    if (type == 'warehouse') {
      return (_warehouseItems.length + 1).toString();
    } else if (type == 'zone') {
      final warehouseName = path.replaceAll('warehouse', '');
      final myWarehouse = _warehouseItems
          .firstWhere((warehouse) => warehouse.name == warehouseName);
      return String.fromCharCode(myWarehouse.zone.length + 1 + 64);
    } else if (type == 'shelf') {
      return (_shelfItems.length + 1).toString();
    }
  }

  String strCreatePathAndName(String path) {
    String? type = _defineType(path);
    String? name = _defineName(type!, path);
    String out = '$type$name ';
    if (path != '') out += 'in ' + path;
    return out;
  }

  Future<void> createPath(String path) async {
    // '' -> add warehouse
    // 'warehouse1' -> add zone
    // 'warehouse1/zoneA' -> add shelf
    // 'warehouse1/zoneA/shelf1' -> no
    try {
      print('creating path...');
      final warehouseName = path.replaceAll('warehouse', '');
      String? type = _defineType(path);
      if (type == null) return;
      String? name = _defineName(type, path);
      if (name == null) return;

      var url = Uri.parse('$ENDPOINT/path');
      final body = json.encode({
        "path": path,
        "type": type,
        "name": name,
      });
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      // print(response.body);
      final extracted = json.decode(response.body);
      if (extracted['isInserted'] == false) throw 'error';
      // await fetchWareHouses();

      // add path
      // if (type == 'zone') {
      //   _warehouseItems
      //       .firstWhere((wareh) => wareh.name == warehouseName)
      //       .zone
      //       .add(Zone(name: name, itemCount: 0));
      // } else if (type == 'warehouse') {
      //   _warehouseItems.add(WareHouse(name: name, zone: []));
      // } else if (type == 'shelf') {
      //   _shelfItems.add(Shelf(name: name, itemCount: 0));
      // }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
