import 'package:flutter/material.dart';

import '../screens/add_product/add_product_screen.dart';
import '../screens/history/history_screen.dart';
import '../screens/order/homepage_screen.dart';
import '../screens/products/products_list_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('List of Products'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListProducts(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('History'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const History(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_rounded),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProduct(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
