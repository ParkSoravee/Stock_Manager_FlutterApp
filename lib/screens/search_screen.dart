import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/widgets/warehouse_list.dart';
import 'package:provider/provider.dart';

import 'delete_item_screen.dart';

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
    Provider.of<WareHouses>(context, listen: false)
        .fetchWareHouses()
        .then((result) {
      if (result == true) {
        setState(() {
          loadedWareHouse =
              Provider.of<WareHouses>(context, listen: false).warehouses;
          // print(loadedWareHouse);
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => DeleteItemScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.drive_file_move_outlined,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : WareHouseLists(loadedWareHouse),
    );
  }
}
