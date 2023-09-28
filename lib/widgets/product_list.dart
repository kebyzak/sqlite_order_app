import 'package:flutter/material.dart';
import 'package:sqlite_order_app/screens/products/update_delete_product_screen.dart';

class ProductListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const ProductListWidget({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DataRow> productRows = [];

    // Define a map to map group IDs to text values
    final groupTextMap = {
      1: 'Drink',
      2: 'Eat',
    };

    for (final product in dataList) {
      final id = product['id'];
      final groupId = product['groupId'] ?? 0;
      final productName = product['name'] ?? '';
      final stockAmount = product['stockAmount'] ?? 0;
      final price = product['price'] ?? 0.0;

      final groupText = groupTextMap[groupId] ?? '';

      final productRow = DataRow(
        cells: [
          DataCell(
            Center(child: Text(groupText)),
          ),
          DataCell(
            Center(child: Text(productName)),
          ),
          DataCell(
            Center(child: Text(stockAmount.toString())),
          ),
          DataCell(
            Center(child: Text(price.toString())),
          ),
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateProduct(id: id),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );

      productRows.add(productRow);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30.0,
        columns: const [
          DataColumn(label: Center(child: Text('Group'))),
          DataColumn(label: Center(child: Text('Name'))),
          DataColumn(
            label: Center(child: Text('Amount')),
            numeric: true,
          ),
          DataColumn(
            label: Center(child: Text('Price')),
            numeric: true,
          ),
          DataColumn(
            label: Center(child: Text('Edit')),
            numeric: true,
          ),
        ],
        rows: productRows,
      ),
    );
  }
}
