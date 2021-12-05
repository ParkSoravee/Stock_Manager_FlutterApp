import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/models/pages_list.dart';
import 'package:flutter_stock_manager/providers/search_item.dart';
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
            textFieldController: textFieldController,
          ),
          Expanded(
            child: !_isSearching
                ? _pages[_selectedPageIndex]['page'] as Widget
                : _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : searchList!,
          ),
        ],
      ),
    );
  }
}
