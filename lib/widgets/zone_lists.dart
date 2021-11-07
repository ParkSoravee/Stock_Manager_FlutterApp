import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:provider/provider.dart';

import 'zone_item.dart';

class ZoneLists extends StatefulWidget {
  final int floor;
  const ZoneLists(this.floor, {Key? key}) : super(key: key);

  @override
  _ZoneListsState createState() => _ZoneListsState();
}

class _ZoneListsState extends State<ZoneLists> {
  late final List<Zone> zones;

  @override
  void initState() {
    zones = Provider.of<WareHouses>(context, listen: false).fetchZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: zones.length,
            itemBuilder: (ctx, i) => ZoneItem(widget.floor, zones[i]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text('${zones.length} items'),
        )
      ],
    );
  }
}
