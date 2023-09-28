import 'package:flutter/material.dart';
import 'package:sqlite_order_app/screens/products/products_list_screen.dart';

import '../../utils/local_db.dart';

class UpdateProduct extends StatefulWidget {
  final int id;

  const UpdateProduct({super.key, required this.id});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _stockAmountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                final updatedData = {
                  'name': _productNameController.text,
                  'stockAmount': int.tryParse(_stockAmountController.text) ?? 0,
                  'price': double.tryParse(_priceController.text) ?? 0,
                };
                Navigator.pop(context, updatedData);
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _productNameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _stockAmountController,
                        decoration: const InputDecoration(
                          labelText: 'Stock Amount',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () async {
                          await LocalDatabase().updateData(
                            id: widget.id,
                            name: _productNameController.text,
                            stockAmount:
                                int.tryParse(_stockAmountController.text) ?? 0,
                            price: double.tryParse(_priceController.text) ?? 0,
                          );
                          await LocalDatabase().readProducts();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ListProducts(),
                            ),
                          );
                        },
                        child: const Text('Update Product'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          LocalDatabase().deleteData(id: widget.id);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ListProducts(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Colors.red[300]),
                        ),
                        child: const Text(
                          'Delete Product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _stockAmountController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
