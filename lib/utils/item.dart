class Item {
  final String? id;
  final String itemId;
  final String itemTitle;
  final DateTime date;
  final String location;

  Item({
    this.id,
    required this.itemId,
    required this.itemTitle,
    required this.date,
    required this.location,
  });
}
