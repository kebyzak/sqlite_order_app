import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      },
                      icon: const Icon(Icons.restaurant_menu_rounded),
                      label: const Text("Main Hall"),
                    ),
                    const SizedBox(width: 16),
                    // Add spacing between the buttons.
                    ElevatedButton.icon(
                      onPressed: () {
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
                      },
                      icon: const Icon(Icons.wallet_rounded),
                      label: const Text("VIP 1"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
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
