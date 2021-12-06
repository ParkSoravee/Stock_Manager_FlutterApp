import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:provider/provider.dart';

import 'warehouse_item.dart';

class WareHouseLists extends StatefulWidget {
  @override
  _WareHouseListsState createState() => _WareHouseListsState();
}

class _WareHouseListsState extends State<WareHouseLists> {
  var _isLoading = true;
  late List<WareHouse> loadedWareHouse;

  Future<void> addItemFunction(String path) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final warehouse = Provider.of<WareHouses>(context, listen: false);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure to create...'),
          content: Text(warehouse.strCreatePathAndName(path)),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Cencel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  await warehouse.createPath(path);
                } catch (error) {
                  throw error;
                }
              },
              child: Text(
                'Create',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      );
      await warehouse.fetchWareHouses();
      loadedWareHouse = warehouse.warehouses;
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Some thing went wrong, please try again later...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false)
        .fetchWareHouses()
        .then((result) {
      if (result == true) {
        setState(() {
          loadedWareHouse =
              Provider.of<WareHouses>(context, listen: false).warehouses;
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: loadedWareHouse.length,
            itemBuilder: (ctx, i) => WareHouseItem(
              wareHouse: loadedWareHouse[i],
              addItemFunction: addItemFunction,
            ),
          );
  }
}
