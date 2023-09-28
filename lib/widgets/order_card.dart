import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productName = order['productName'];
    final productQuantity = order['productQuantity'];
    final room = order['room'];
    final cost = order['cost'];

    final productInfo = _formatProductInfo(productName, productQuantity);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cost: \$${cost.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Products:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(productInfo),
            const SizedBox(height: 8),
            Text(
              'Room: $room',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _formatProductInfo(
      List<String>? productNames, List<int>? productQuantities) {
    if (productNames == null || productQuantities == null) {
      return 'No products';
    }

    final List<String> products = [];

    if (productNames.length != productQuantities.length) {
      return 'Data mismatch';
    }

    for (int i = 0; i < productNames.length; i++) {
      final productName = productNames[i];
      final productQuantity = productQuantities[i];

      products.add('$productName - $productQuantity');
    }

    if (products.isEmpty) {
      return 'No products';
    }

    return products.join(', ');
  }
}
