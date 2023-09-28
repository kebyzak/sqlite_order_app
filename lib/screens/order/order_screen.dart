import 'package:flutter/material.dart';
import 'package:sqlite_order_app/utils/local_db.dart';

import '../../models/order.dart';
import '../../models/product.dart';

class OrderScreen extends StatefulWidget {
  final String room;

  const OrderScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  List<Product> eatProducts = [];
  List<Product> drinkProducts = [];
  List<Product> selectedProducts = [];
  double totalAmount = 0.0;
  double cost = 0.0;
  String selectedCategory = 'Eat';

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  Future<void> getDataFromDB() async {
    final db = LocalDatabase();
    await db.readProducts();

    eatProducts = Product.mapToProducts(dataList, 2);
    drinkProducts = Product.mapToProducts(dataList, 1);

    setState(() {});
  }

  void groupTotalPrice() {
    double total = 0.0;
    for (final product in selectedProducts) {
      total += product.price * product.quantity;
    }
    setState(() {
      totalAmount = total;
      updatecost(); // Update cost
    });
  }

  void updatecost() {
    double eatTotal = 0.0;
    double drinkTotal = 0.0;

    for (final product in eatProducts) {
      eatTotal += product.price * product.quantity;
    }

    for (final product in drinkProducts) {
      drinkTotal += product.price * product.quantity;
    }

    cost = eatTotal + drinkTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make an Order'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (category) {
                setState(() {
                  selectedCategory = category!;
                });
              },
              items: ['Eat', 'Drink'].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedCategory == 'Eat'
                  ? eatProducts.length
                  : drinkProducts.length,
              itemBuilder: (context, index) {
                final product = selectedCategory == 'Eat'
                    ? eatProducts[index]
                    : drinkProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                      Text('Stock: ${product.stockAmount}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 0) {
                              product.quantity--;
                              groupTotalPrice();
                            }
                            if (product.quantity == 0 &&
                                selectedProducts.contains(product)) {
                              selectedProducts.remove(product);
                            }
                          });
                        },
                      ),
                      Text(product.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            product.quantity++;
                            if (!selectedProducts.contains(product)) {
                              selectedProducts.add(product);
                            }
                            groupTotalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final List<Map<String, dynamic>> orderItems =
                  selectedProducts.map((product) {
                return {
                  "productName": product.name,
                  "productPrice": product.price,
                  "productQuantity": product.quantity,
                };
              }).toList();

              double totalCost = orderItems.fold(0.0, (acc, item) {
                return acc + (item["productPrice"] * item["productQuantity"]);
              });

              final order = Order(
                room: widget.room,
                cost: totalCost,
                orderItems: orderItems,
              );

              final db = LocalDatabase();
              await db.addOrder(order);

              for (final item in selectedProducts) {
                await db.updateStockAmount(item.name, item.quantity);
              }

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(room: widget.room),
                ),
              );
            },
            child: const Text('Make Order'),
          ),
          Text('Total: $cost'),
        ],
      ),
    );
  }
}
