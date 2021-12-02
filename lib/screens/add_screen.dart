import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/screens/scanner_screen.dart';
import 'package:flutter_stock_manager/widgets/holding_list.dart';
import 'package:provider/provider.dart';

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
          content: Text('Barcode is not valid, please try again...'),
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
    // Provider.of<HoldingItems>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScannerScreen(addToHoldingItems),
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
                Container(
                  width: double.infinity,
                  child: const Text(
                    'รอเข้าคลัง',
                    style: TextStyle(fontSize: 25),
                  ),
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
