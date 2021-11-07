import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';

import 'warehouse_item.dart';

class WareHouseLists extends StatelessWidget {
  final List<WareHouse> loadedWareHouse;
  const WareHouseLists(this.loadedWareHouse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loadedWareHouse.length,
      itemBuilder: (ctx, i) => WareHouseItem(wareHouse: loadedWareHouse[i]),
    );
  }
}
