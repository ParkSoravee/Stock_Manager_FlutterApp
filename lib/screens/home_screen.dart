import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/pages_list.dart';
import 'package:flutter_stock_manager/providers/search_item.dart';
import 'package:flutter_stock_manager/providers/warehouses.dart';
import 'package:flutter_stock_manager/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  final int initPage;
  const HomeScreen({this.initPage = 1, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = PageList().pagesList;

  var _selectedPageIndex;

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

        if (_selectedPageIndex == 0) {
          searchList = await Provider.of<SearchItem>(context, listen: false)
              .historySearch(value);
        } else {
          searchList = await Provider.of<SearchItem>(context, listen: false)
              .itemSearch(value, '', context);
        }

        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('error: ' + error.toString());
    }
  }

  void addItemFunction(String path) async {
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
                Navigator.pop(context);
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

  @override
  void initState() {
    _selectedPageIndex = widget.initPage;
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      textFieldController.clear();
      searchList = null;
      _isSearching = false;
    });
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
      body: Column(
        children: [
          TopBar(
            isMain: true,
            pageTitle: _pages[_selectedPageIndex]['title'].toString(),
            searchFn: selectSearchFunction,
            addItemFunction: addItemFunction,
            textFieldController: textFieldController,
            path: _selectedPageIndex == 1 ? '' : null,
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : !_isSearching
                    ? _pages[_selectedPageIndex]['page'] as Widget
                    : searchList!,
          ),
        ],
      ),
    );
  }
}
