import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // final List<Map<String,String>> _items
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Add page'),
    );
  }
}
