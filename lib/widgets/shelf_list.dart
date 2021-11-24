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
  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false).fetchShelfs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Shelf> shelfs =
        Provider.of<WareHouses>(context, listen: false).shelfs;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shelfs.length,
            itemBuilder: (ctx, i) => ShelfItem(
              wareHouseName: widget.wareHouseName,
              zoneName: widget.zoneName,
              shelfItem: shelfs[i],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text('${shelfs.length} items'),
        )
      ],
    );
  }
}
