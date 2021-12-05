import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final bool isMain;
  final String pageTitle;
  final String? backTitle;
  final Function(String)? searchFn;
  final TextEditingController textFieldController;

  const TopBar({
    required this.isMain,
    required this.pageTitle,
    this.backTitle,
    this.searchFn,
    required this.textFieldController,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
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
                      height: 0.9,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  height: 30,
                  width: double.infinity,
                  child: Stack(
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
                        right: 10,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          splashColor: Theme.of(context).backgroundColor,
                          child: const Icon(
                            Icons.more_horiz,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          child: TextField(
                            controller: widget.textFieldController,
                            onChanged: widget.searchFn,
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
                  child: IconButton(
                    splashRadius: 24,
                    onPressed: () {
                      // print(DateTime.parse('2021-11-05T16:36:40.818110').hour);
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
