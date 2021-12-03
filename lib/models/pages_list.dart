import 'package:flutter_stock_manager/screens/add_screen.dart';
import 'package:flutter_stock_manager/screens/history_screen.dart';
import 'package:flutter_stock_manager/screens/search_screen.dart';

class PageList {
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

  List<Map<String, Object>> get pagesList {
    return _pages;
  }
}
