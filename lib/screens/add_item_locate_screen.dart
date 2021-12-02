import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';

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
          // ScannerWidget(),
          //TODO Scan place and confirm screen to add item
          Expanded(
            child: ListView(
              children: [
                Text('detail...'),
                TextButton(
                  onPressed: () {},
                  child: Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
