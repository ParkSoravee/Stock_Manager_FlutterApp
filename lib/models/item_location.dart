class ItemLocation {
  late final String path;
  late String warehouse; // '1'
  late String zone; // 'A'
  late String shelf; // 3
  late String slot; // '1-A'

  ItemLocation(String fullPath) {
    // 'warehouse1/zoneA/shelf2&1-A'
    final pathSplit = fullPath.split('&');
    this.path = pathSplit[0];
    this.slot = pathSplit[1];
    final seperatedPath = this.path.split('/');
    this.warehouse = seperatedPath[0].replaceAll('warehouse', '');
    this.zone = seperatedPath[1].replaceAll('zone', '');
    this.shelf = seperatedPath[2].replaceAll('shelf', '');
  }
}
