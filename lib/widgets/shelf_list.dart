import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:provider/provider.dart';

import 'shelf_item.dart';

class ShelfList extends StatefulWidget {
  final String wareHouseName;
  final String zoneName;
  // final Shelf shelfs;
  const ShelfList({
    required this.wareHouseName,
    required this.zoneName,
  });

  @override
  _ShelfListState createState() => _ShelfListState();
}

class _ShelfListState extends State<ShelfList> {
  var _isLoading = true;
  late final loadedShelfs;
  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false)
        .fetchShelfs(widget.wareHouseName, widget.zoneName)
        .then((_) {
      setState(() {
        loadedShelfs = Provider.of<WareHouses>(context, listen: false).shelfs;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: loadedShelfs.length,
                  itemBuilder: (ctx, i) => ShelfItem(
                    wareHouseName: widget.wareHouseName,
                    zoneName: widget.zoneName,
                    shelfItem: loadedShelfs[i],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Text('${loadedShelfs.length} items'),
              )
            ],
          );
  }
}
