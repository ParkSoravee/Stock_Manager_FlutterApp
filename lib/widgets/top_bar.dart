import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MenuOptions {
  Add,
  ListView,
  GridView,
}

class TopBar extends StatefulWidget {
  final bool isMain;
  final String pageTitle;
  final String? backTitle;
  final Function(String?)? searchFn;
  final Function(String) addItemFunction;
  final TextEditingController textFieldController;
  final String? path;

  const TopBar({
    required this.isMain,
    required this.pageTitle,
    this.backTitle,
    this.searchFn,
    required this.addItemFunction,
    required this.textFieldController,
    this.path,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final _textFieldKey = GlobalKey<FormFieldState>();
  Future<void> selectDateRange() async {
    final _dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2021, 11),
      lastDate: DateTime(2023),
    );
    if (_dateRange == null) return;
    final _dateSelected =
        'date:${DateFormat('yyyy/MM/dd').format(_dateRange.start)}-${DateFormat('yyyy/MM/dd').format(_dateRange.end)}';
    // print(_dateSelected);
    // setState(() {
    widget.textFieldController.text = _dateSelected;
    _textFieldKey.currentState!.save();
    // });
  }

  Widget _menu() {
    return widget.path == null || widget.path!.contains('shelf')
        ? widget.pageTitle == 'ประวัติ'
            ? IconButton(
                onPressed: selectDateRange,
                icon: Icon(
                  CupertinoIcons.calendar,
                  color: Colors.white,
                  size: 28,
                ),
                splashRadius: 30,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 32,
                ),
              )
        : PopupMenuButton<MenuOptions>(
            onSelected: (MenuOptions selectedOption) {
              if (selectedOption == MenuOptions.Add) {
                widget.addItemFunction(widget.path!);
              }
            },
            offset: Offset.fromDirection(pi / 2, 50),
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 32,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // padding: EdgeInsets.zero,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuOptions.Add,
                child: Container(
                  child: Text(
                    widget.path!.contains('zone')
                        ? 'เพิ่มชั้นวาง'
                        : 'เพิ่มโกดัง',
                  ),
                  width: 140,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: MenuOptions.ListView,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('List'),
                      Icon(Icons.format_list_bulleted),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              PopupMenuItem(
                value: MenuOptions.GridView,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Icon'),
                      Icon(CupertinoIcons.square_grid_2x2),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
        left: 18,
        right: widget.isMain ? 5 : 18,
        top: 10,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          widget.isMain
              ? Container(
                  width: double.infinity,
                  child: Text(
                    widget.pageTitle,
                    style: const TextStyle(
                      fontSize: 30,
                      height: 0.8,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  height: 30,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.pageTitle,
                          style: const TextStyle(
                            fontSize: 26,
                            height: 0.9,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -10,
                        // child: InkWell(
                        //   borderRadius: BorderRadius.circular(20),
                        //   onTap: moreTapFunction,
                        //   splashColor: Theme.of(context).backgroundColor,
                        //   child: const Icon(
                        //     Icons.more_horiz,
                        //     size: 30,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        child: _menu(),
                      ),
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                widget.backTitle != null
                                    ? widget.backTitle!
                                    : '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  decoration: BoxDecoration(
                    color: const Color(0xffe26b2d),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      if (widget.searchFn != null)
                        Expanded(
                          child: TextFormField(
                            key: _textFieldKey,
                            controller: widget.textFieldController,
                            onChanged: widget.searchFn,
                            onSaved: widget.searchFn,
                            cursorColor: Colors.white60,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofillHints: null,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.fromLTRB(7, 0, 6, 5),
                              border: InputBorder.none,
                              // suffixIcon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                      if (widget.textFieldController.text != '')
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              widget.textFieldController.text = '';
                              _textFieldKey.currentState!.save();
                            },
                            splashColor: Colors.white10,
                            splashRadius: 15,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white60,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (widget.isMain)
                Material(
                  color: Colors.transparent,
                  // child: IconButton(
                  //   splashRadius: 24,
                  //   onPressed: moreTapFunction,
                  //   icon: const Icon(
                  //     Icons.more_horiz,
                  //     color: Colors.white,
                  //     size: 32,
                  //   ),
                  // ),
                  child: _menu(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
