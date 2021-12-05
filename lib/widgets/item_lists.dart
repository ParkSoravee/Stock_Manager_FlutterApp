import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/detail_screen.dart';
import 'package:flutter_stock_manager/screens/main_detail_screen.dart';
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
                  itemBuilder: (ctx, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MainDetailScreen(
                            path:
                                'warehouse${widget.wareHouseName}/zone${widget.zoneName}/shelf${widget.shelfName}',
                            title: 'รายละเอียด',
                            backTitle: 'ชั้นวาง ${widget.shelfName}',
                            showScreen: DetailScreen(
                              itemId: _loadedItems[i].itemId,
                            ),
                          ),
                        ),
                      );
                    },
                    child: ItemListTile(
                      position: _loadedItems[i].slot,
                      itemId: _loadedItems[i].itemId,
                      itemTitle: _loadedItems[i].itemTitle,
                      date: _loadedItems[i].dateIn,
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
