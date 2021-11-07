import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/screens/scanner_screen.dart';
import 'package:flutter_stock_manager/widgets/holding_list.dart';
import 'package:flutter_stock_manager/widgets/item_list_tile.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScannerScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
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
                  thickness: 0.6,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          HoldingList(),
        ],
      ),
    );
  }
}
