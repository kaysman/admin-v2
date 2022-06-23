class OrderColumn {
  final String name;
  final bool? hide;
  final bool? hideByDefault;

  const OrderColumn(
    this.name, {
    this.hide,
    this.hideByDefault,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderColumn && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "$name, $hideByDefault";
}
