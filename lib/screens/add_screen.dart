import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/screens/scanner_screen.dart';
import 'package:flutter_stock_manager/widgets/holding_list.dart';
import 'package:provider/provider.dart';

import 'add_item_locate_screen.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  void addToHoldingItems(BuildContext context, String barcode) async {
    print(barcode);
    try {
      await Provider.of<HoldingItems>(context, listen: false)
          .addHoldingItem(barcode);
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Barcode is invalid, please try again...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
    }
  }

  void addItemByQR(BuildContext context) async {
    try {
      var _itemId = '';

      void setItemId(BuildContext context, String qrcode) {
        _itemId = qrcode;
      }

      final holdingItem = Provider.of<HoldingItems>(context, listen: false);
      // Scanner QR id
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScannerScreen(
            setValueFn: setItemId,
            isQr: true,
          ),
        ),
      );
      // print(_itemId);
      if (_itemId == '') return;
      final myHoldingItem = holdingItem.findByItemId(_itemId);
      // Go to add place and confirm screen
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AddItemLocateScreen(
            holdingItem: myHoldingItem,
          ),
        ),
      );
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('QRcode is invalid, please try again...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScannerScreen(setValueFn: addToHoldingItems),
            ),
          );
        },
        child: const Icon(
          CupertinoIcons.add,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'เลือกสินค้าเข้าคลัง',
                      style: TextStyle(fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {
                        addItemByQR(context);
                      },
                      icon: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      splashRadius: 27,
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          const HoldingList(),
        ],
      ),
    );
  }
}
