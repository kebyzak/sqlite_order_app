import 'package:flutter/material.dart';
import 'package:sqlite_order_app/widgets/app_drawer.dart';

import '../../widgets/app_appbar.dart';
import 'order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToOrderScreen(BuildContext context, String room) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderScreen(room: room),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order App'),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _navigateToOrderScreen(context, "Main Hall");
                      },
                      icon: const Icon(Icons.restaurant_menu_rounded),
                      label: const Text("Main Hall"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _navigateToOrderScreen(context, "Summer Hall");
                      },
                      icon: const Icon(Icons.sunny),
                      label: const Text("Summer Hall"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _navigateToOrderScreen(context, "VIP 1");
                      },
                      icon: const Icon(Icons.wallet_rounded),
                      label: const Text("VIP 1"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _navigateToOrderScreen(context, "VIP 2");
                      },
                      icon: const Icon(Icons.account_balance_wallet_rounded),
                      label: const Text("VIP 2"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
