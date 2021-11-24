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
  var _isLoading = true;
  late List<WareHouse> loadedWareHouse;

  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false).fetchWareHouses().then((_) {
      setState(() {
        loadedWareHouse =
            Provider.of<WareHouses>(context, listen: false).warehouses;
        // print(loadedWareHouse);
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : WareHouseLists(loadedWareHouse);
  }
}
