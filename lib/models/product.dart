class Product {
  final String name;
  final double price;
  final int stockAmount;
  final int groupId;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.stockAmount,
    required this.groupId,
    this.quantity = 0,
  });

  static List<Product> mapToProducts(
      List<Map<String, dynamic>> dataList, int groupId) {
    return dataList
        .where((product) => product['groupId'] == groupId)
        .map((product) => Product(
              name: product['name'],
              price: product['price'].toDouble(),
              stockAmount: product['stockAmount'],
              groupId: product['groupId'],
              quantity: 0,
            ))
        .toList();
  }
}
