import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String pageTitle;
  const TopBar(
    this.pageTitle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(
        left: 18,
        right: 5,
        top: 10,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          Container(
            width: double.infinity,
            child: Text(
              pageTitle,
              style: const TextStyle(
                fontSize: 30,
                height: 0.9,
                color: Colors.white,
              ),
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
                    children: const [
                      Icon(
                        CupertinoIcons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                splashRadius: 24,
                padding: const EdgeInsets.only(left: 0, right: 0),
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
