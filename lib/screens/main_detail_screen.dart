import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/screens/history_detail_screen.dart';
import 'package:flutter_stock_manager/utils/bottom_navigation.dart';
import 'package:flutter_stock_manager/widgets/top_bar.dart';

class MainDetailScreen extends StatelessWidget {
  final Widget showScreen;
  const MainDetailScreen({Key? key, required this.showScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedPageIndex = 0;

    void _selectPage(int index) {} //TODO

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
          const TopBar(
            isMain: false,
            pageTitle: 'รายละเอียด',
            backTitle: 'ประวัติ',
          ),
          Expanded(child: showScreen),
        ],
      ),
    );
  }
}
