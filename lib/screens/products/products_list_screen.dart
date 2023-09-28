import 'package:flutter/material.dart';
import 'package:sqlite_order_app/widgets/app_drawer.dart';

import '../../utils/local_db.dart';
import '../../widgets/app_appbar.dart';
import '../../widgets/product_list.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({super.key});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    await LocalDatabase().readProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'List Of Products'),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ProductListWidget(
              dataList: dataList.cast<Map<String, dynamic>>(),
            ),
          ),
        ),
      ),
    );
  }
}
