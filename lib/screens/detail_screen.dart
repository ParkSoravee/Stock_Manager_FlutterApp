import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/item.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String itemId;
  const DetailScreen({
    required this.itemId,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Item loadedItemDetail;
  var _isLoading = true;

  @override
  void initState() {
    Provider.of<WareHouses>(context, listen: false)
        .fetchItemDetail(widget.itemId)
        .then((detail) {
      setState(() {
        loadedItemDetail = detail;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: MediaQuery.of(context).size.width * 10 / 100,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    loadedItemDetail.itemTitle,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text('barcode: ${loadedItemDetail.barcode}'),
                  ListTile(
                    leading: Text('ID สินค้า:'),
                    title: Text(loadedItemDetail.itemId),
                  ),
                  const Divider(),
                  if (loadedItemDetail.path != null &&
                      loadedItemDetail.slot != null)
                    Column(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 1.5)),
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            loadedItemDetail.slot!,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Text(
                          'Warehouse: ' + loadedItemDetail.warehouseName!,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Zone: ' + loadedItemDetail.zoneName!,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Shelf: ' + loadedItemDetail.shelfName!,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันเข้า',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat(
                              'dd/MM/yyyy HH:mm น.',
                            ).format(loadedItemDetail.dateIn),
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันออก',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            loadedItemDetail.dateOut != null
                                ? DateFormat(
                                    'dd/MM/yyyy HH:mm น.',
                                  ).format(loadedItemDetail.dateOut!)
                                : '--/--/---- --:-- น.',
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    height: 25,
                  ),
                  Text(
                    loadedItemDetail.description!,
                  ),
                ],
              ),
            ),
          );
    ;
  }
}
