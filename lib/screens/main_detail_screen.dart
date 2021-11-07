import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/widgets/bottom_navigation.dart';
import 'package:flutter_stock_manager/widgets/top_bar.dart';

class MainDetailScreen extends StatelessWidget {
  final Widget showScreen;
  final String title;
  final String backTitle;
  const MainDetailScreen({
    Key? key,
    required this.showScreen,
    required this.title,
    required this.backTitle,
  }) : super(key: key);

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
          TopBar(
            isMain: false,
            pageTitle: title,
            backTitle: backTitle,
          ),
          Expanded(child: showScreen),
        ],
      ),
    );
  }
}
