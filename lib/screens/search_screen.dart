import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/widgets/warehouse_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false).fetchWareHouse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadedWareHouse =
        Provider.of<WareHouses>(context, listen: false).items;
    return WareHouseLists(loadedWareHouse);
  }
}
