class Item {
  final String? barcode;
  final String itemId;
  final String itemTitle;
  final String? path;
  final String? slot;
  final DateTime dateIn;
  final DateTime? dateOut;
  final String? description;

  Item({
    this.barcode,
    required this.itemId,
    required this.itemTitle,
    required this.dateIn,
    this.dateOut,
    this.path,
    this.slot,
    this.description,
  });

  String? get warehouseName {
    if (this.path == null || this.slot == null) {
      return null;
    }
    final splitedPath = this.path!.split('/');
    return splitedPath[0].replaceAll('warehouse', '');
  }

  String? get zoneName {
    if (this.path == null || this.slot == null) {
      return null;
    }
    final splitedPath = this.path!.split('/');
    return splitedPath[1].replaceAll('zone', '');
  }

  String? get shelfName {
    if (this.path == null || this.slot == null) {
      return null;
    }
    final splitedPath = this.path!.split('/');
    return splitedPath[2].replaceAll('shelf', '');
  }
}
