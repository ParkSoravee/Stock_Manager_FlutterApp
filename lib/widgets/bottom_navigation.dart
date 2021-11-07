import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Function(int) ontap;
  final int selectedPageIndex;
  const CustomBottomNavigationBar(
    this.ontap,
    this.selectedPageIndex,
  );

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ontap,
      currentIndex: selectedPageIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      fixedColor: Colors.white,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          label: 'History',
          icon: Icon(
            Icons.history,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Search',
          icon: Icon(
            CupertinoIcons.search,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Add',
          icon: Icon(
            Icons.add_box_outlined,
          ),
        ),
      ],
    );
  }
}
