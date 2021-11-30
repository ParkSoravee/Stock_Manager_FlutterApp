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
            location: itemData['location'],
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
        location: extractedProductDetail['location'],
        description: extractedProductDetail['description'],
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
