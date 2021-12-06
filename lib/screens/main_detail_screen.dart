import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/pages_list.dart';
import 'package:flutter_stock_manager/providers/search_item.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/screens/home_screen.dart';
import 'package:flutter_stock_manager/widgets/bottom_navigation.dart';
import 'package:flutter_stock_manager/widgets/top_bar.dart';
import 'package:provider/provider.dart';

import 'delete_item_screen.dart';

class MainDetailScreen extends StatefulWidget {
  final Widget showScreen;
  final String title;
  final String backTitle;
  final String path;
  final bool isHistory;

  const MainDetailScreen({
    Key? key,
    required this.showScreen,
    required this.title,
    required this.backTitle,
    this.isHistory = false,
    required this.path,
  }) : super(key: key);

  @override
  _MainDetailScreenState createState() => _MainDetailScreenState();
}

class _MainDetailScreenState extends State<MainDetailScreen> {
  var _selectedPageIndex;

  final _pages = PageList().pagesList;

  var _isSearching = false;
  var _isLoading = false;

  Widget? searchList;

  final textFieldController = TextEditingController();

  void selectSearchFunction(String? value) async {
    try {
      print('in selectSearch fn');
      if (value == '' || value == null) {
        setState(() {
          _isSearching = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isSearching = true;
          _isLoading = true;
        });

        if (widget.isHistory) {
          searchList = await Provider.of<SearchItem>(context, listen: false)
              .historySearch(value);
        } else {
          searchList = await Provider.of<SearchItem>(context, listen: false)
              .itemSearch(value, widget.path, context);
        }

        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('error: ' + error.toString());
    }
  }

  Future<void> addItemFunction(String path) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final warehouse = Provider.of<WareHouses>(context, listen: false);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure to create...'),
          content: Text(warehouse.strCreatePathAndName(path)),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Cencel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                try {
                  await warehouse.createPath(path);
                } catch (error) {
                  throw error;
                }
              },
              child: Text(
                'Create',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Some thing went wrong, please try again later...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectPage(int index) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(
          initPage: index,
        ),
      ),
    );
  }

  @override
  void initState() {
    _selectedPageIndex = widget.isHistory == true ? 0 : 1;
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(_selectPage, _selectedPageIndex),
      floatingActionButton: widget.isHistory
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DeleteItemScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.drive_file_move_outlined,
                size: 30,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 2,
            ),
      body: Column(
        children: [
          TopBar(
            isMain: false,
            pageTitle: widget.title,
            backTitle: widget.backTitle,
            textFieldController: textFieldController,
            searchFn: selectSearchFunction,
            addItemFunction: addItemFunction,
            path: widget.isHistory ? null : widget.path,
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : !_isSearching
                    ? widget.showScreen
                    : searchList!,
          ),
        ],
      ),
    );
  }
}
