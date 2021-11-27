class Item {
  final String? barcode;
  final String itemId;
  final String itemTitle;
  final String location;
  final DateTime dateIn;
  final DateTime? dateOut;
  final String? description;

  Item({
    this.barcode,
    required this.itemId,
    required this.itemTitle,
    required this.dateIn,
    this.dateOut,
    required this.location,
    this.description,
  });
}
