import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/widgets/bottom_navigation.dart';

import 'add_screen.dart';
import 'history_screen.dart';
import 'search_screen.dart';
import '../widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': const HistoryScreen(),
      'title': 'ประวัติ',
    },
    {
      'page': const SearchScreen(),
      'title': 'ค้นหา',
    },
    {
      'page': const AddScreen(),
      'title': 'เพิ่มของ',
    },
  ];
  var _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
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
          ),
          Expanded(child: _pages[_selectedPageIndex]['page'] as Widget)
        ],
      ),
    );
  }
}
