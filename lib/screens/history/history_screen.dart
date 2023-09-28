import 'package:flutter/material.dart';
import 'package:sqlite_order_app/widgets/app_drawer.dart';
import 'package:sqlite_order_app/widgets/order_card.dart';

import '../../utils/local_db.dart';
import '../../widgets/app_appbar.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> orderList = [];

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  Future<void> _getOrders() async {
    final orders = await LocalDatabase().readOrders();
    setState(() {
      orderList = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'History of Orders'),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            return OrderCard(order: orderList[index]);
          },
        ),
      ),
    );
  }
}
