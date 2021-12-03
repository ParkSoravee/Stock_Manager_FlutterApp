import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/widgets/bottom_navigation.dart';
import 'package:flutter_stock_manager/widgets/top_bar.dart';

import 'delete_item_screen.dart';

class MainDetailScreen extends StatelessWidget {
  final Widget showScreen;
  final String title;
  final String backTitle;
  final bool isHistory;

  const MainDetailScreen({
    Key? key,
    required this.showScreen,
    required this.title,
    required this.backTitle,
    this.isHistory = false,
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
      floatingActionButton: isHistory
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
            pageTitle: title,
            backTitle: backTitle,
          ),
          Expanded(child: showScreen),
        ],
      ),
    );
  }
}
