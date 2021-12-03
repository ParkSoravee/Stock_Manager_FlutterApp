import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/item_location.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/widgets/scanner_widget.dart';
import 'package:provider/provider.dart';

class AddItemLocateScreen extends StatefulWidget {
  final HoldingItem holdingItem;
  const AddItemLocateScreen({
    required this.holdingItem,
    Key? key,
  }) : super(key: key);

  @override
  _AddItemLocateScreenState createState() => _AddItemLocateScreenState();
}

class _AddItemLocateScreenState extends State<AddItemLocateScreen> {
  ItemLocation? _itemLocation;
  var _loading = true;

  void setItemLocation(String path) {
    path = path.split(':')[1];
    setState(() {
      _itemLocation = ItemLocation(path);
      _loading = false;
    });
  }

  Future<void> addItem() async {
    try {
      setState(() {
        _loading = true;
      });
      await Provider.of<HoldingItems>(context, listen: false).addItem(
        itemId: widget.holdingItem.itemId,
        itemName: widget.holdingItem.itemTitle,
        itemLocation: _itemLocation!,
      );
      Navigator.pop(context);
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Please try again later...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'เพิ่มของเข้าคลัง',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.amber,
            child: ScannerWidget(
              setValueFn: setItemLocation,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.holdingItem.itemTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('ID: ' + widget.holdingItem.itemId),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  // Text('Location'),
                  if (_itemLocation == null)
                    Text('- Scanning location\'s QR code... -'),
                  if (_itemLocation != null)
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 1.5)),
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _itemLocation!.slot,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  if (_itemLocation != null)
                    Text(
                      'Warehouse: ' + _itemLocation!.warehouse,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  if (_itemLocation != null)
                    Text(
                      'Zone: ' + _itemLocation!.zone,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  if (_itemLocation != null)
                    Text(
                      'Shelf: ' + _itemLocation!.shelf,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  _itemLocation == null || _loading == true
                      ? CircularProgressIndicator(
                          color: const Color(0xFFFF8244),
                        )
                      : ElevatedButton(
                          onPressed: addItem,
                          child: Text(
                            'Confirm',
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
