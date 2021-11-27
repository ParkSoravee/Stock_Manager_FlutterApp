import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/utils/item.dart';
import 'package:flutter_stock_manager/widgets/item_list_tile.dart';
import 'package:provider/provider.dart';

class ItemLists extends StatefulWidget {
  final String wareHouseName;
  final String zoneName;
  final String shelfName;

  const ItemLists({
    required this.wareHouseName,
    required this.zoneName,
    required this.shelfName,
  });

  @override
  State<ItemLists> createState() => _ItemListsState();
}

class _ItemListsState extends State<ItemLists> {
  var _isLoading = true;
  late final _loadedItems;

  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false)
        .fetchItems(
      widget.wareHouseName,
      widget.zoneName,
      widget.shelfName,
    )
        .then((_) {
      setState(() {
        _loadedItems = Provider.of<WareHouses>(context, listen: false).items;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Item> _loadedItems = Provider.of<WareHouses>(context).items;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _loadedItems.length,
                  itemBuilder: (ctx, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ItemListTile(
                          position: _loadedItems[i].location,
                          itemId: _loadedItems[i].itemId,
                          itemTitle: _loadedItems[i].itemTitle,
                          date: _loadedItems[i].date,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Text('${_loadedItems.length} items'),
              )
            ],
          );
  }
}
