class Order {
  final List<Map<String, dynamic>> orderItems;
  final String room;
  final double cost;

  Order({
    required this.orderItems,
    required this.cost,
    required this.room,
  });
}
