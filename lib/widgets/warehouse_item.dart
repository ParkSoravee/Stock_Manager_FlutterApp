import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/widgets/floor_item.dart';

class WareHouseItem extends StatefulWidget {
  final WareHouse wareHouse;
  const WareHouseItem({
    Key? key,
    required this.wareHouse,
  }) : super(key: key);

  @override
  _WareHouseItemState createState() => _WareHouseItemState();
}

class _WareHouseItemState extends State<WareHouseItem> {
  var isExpand = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'โกดัง ${widget.wareHouse.id}',
                    style: const TextStyle(fontSize: 21),
                  ),
                  Icon(
                    isExpand
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          if (isExpand)
            for (var i = 0; i < widget.wareHouse.floor.length; i++)
              FloorItem(i, widget.wareHouse.id, widget.wareHouse.floor[i]),
        ],
      ),
    );
  }
}
