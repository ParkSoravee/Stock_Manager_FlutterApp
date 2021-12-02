import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/holding_item.dart';
import 'package:flutter_stock_manager/screens/add_item_locate_screen.dart';
import 'package:flutter_stock_manager/widgets/history_item_list_tile.dart';
import 'package:provider/provider.dart';

class HoldingList extends StatefulWidget {
  const HoldingList({Key? key}) : super(key: key);

  @override
  _HoldingListState createState() => _HoldingListState();
}

class _HoldingListState extends State<HoldingList> {
  var _isLoading = true;
  // late List<HoldingItem> loadedHoldingItem;

  @override
  void initState() {
    Provider.of<HoldingItems>(context, listen: false)
        .fetchAndSetHoldingItem()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadedHoldingItem = Provider.of<HoldingItems>(context).items;
    return Expanded(
      child: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: loadedHoldingItem.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: () {
                    // Go to add place and confirm screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddItemLocateScreen(
                          holdingItem: loadedHoldingItem[i],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: HistoryItemListTile(
                      itemId: loadedHoldingItem[i].itemId,
                      itemTitle: loadedHoldingItem[i].itemTitle,
                      date: loadedHoldingItem[i].date,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
