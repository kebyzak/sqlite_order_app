import 'package:flutter/material.dart';
import 'package:sqlite_order_app/screens/products/products_list_screen.dart';
import 'package:sqlite_order_app/widgets/app_appbar.dart';
import 'package:sqlite_order_app/widgets/app_drawer.dart';

import '../../utils/local_db.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _stockAmountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _groupIdController = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      drawer: const AppDrawer(),
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
                      DropdownButtonFormField<String>(
                        value: _groupIdController == 1 ? 'Drink' : 'Eat',
                        onChanged: (newValue) {
                          setState(() {
                            _groupIdController = newValue == 'Drink' ? 1 : 2;
                          });
                        },
                        items: <String>['Drink', 'Eat']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
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
                          await LocalDatabase().addData(
                            groupId: _groupIdController,
                            name: _productNameController.text,
                            stockAmount: _stockAmountController.text,
                            price: _priceController.text,
                          );
                          await LocalDatabase().readProducts();
                          setState(() {});
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ListProducts(),
                            ),
                          );
                        },
                        child: const Text('Add Product'),
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
