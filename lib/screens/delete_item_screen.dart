import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/item.dart';
import 'package:flutter_stock_manager/models/item_location.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/home_screen.dart';
import 'package:flutter_stock_manager/widgets/scanner_widget.dart';
import 'package:provider/provider.dart';

class DeleteItemScreen extends StatefulWidget {
  const DeleteItemScreen({Key? key}) : super(key: key);

  @override
  _DeleteItemScreenState createState() => _DeleteItemScreenState();
}

class _DeleteItemScreenState extends State<DeleteItemScreen> {
  String? _itemId;
  ItemLocation? _itemLocation;
  Item? _item;
  var _isLoading = true;

  void setItemById(String code) {
    _itemId = code;
    fetchAndSetItemDetail();
  }

  Future<void> fetchAndSetItemDetail() async {
    try {
      _item = await Provider.of<WareHouses>(context, listen: false)
          .fetchItemDetail(_itemId!);
      if (_item == null || _item!.path == null || _item!.slot == null) {
        throw 'Invalid item...';
      }
      _itemLocation = ItemLocation('${_item!.path}&${_item!.slot}');

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Invalid item...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> exportItem() async {
    print(_itemId);
    try {
      await Provider.of<HoldingItems>(context, listen: false).removeItem(
        itemId: _item!.itemId,
        path: _itemLocation!.path,
      );
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Export successful!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('can not export item...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'นำสินค้าออก',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.amber,
            child: ScannerWidget(
              setValueFn: setItemById,
              isItemId: true,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('- Scanning ITEM\'s QR code... -'),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          color: const Color(0xFFFF8244),
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _item!.itemTitle,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Barcode: ' + _item!.barcode!),
                        Text('ID: ' + _item!.itemId),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 1,
                          indent: 15,
                          endIndent: 15,
                        ),
                        Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 1.5)),
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            _itemLocation!.slot,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Text(
                          'Warehouse: ' + _itemLocation!.warehouse,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Zone: ' + _itemLocation!.zone,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Shelf: ' + _itemLocation!.shelf,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: exportItem,
                          child: Text(
                            'Export',
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
