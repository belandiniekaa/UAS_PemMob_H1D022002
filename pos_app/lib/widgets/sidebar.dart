import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[800]),
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.pink[800]),
            title: const Text('Dashboard'),
            onTap: () => Get.toNamed('/dashboard'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.pink[800]),
            title: const Text('Kasir'),
            onTap: () => Get.toNamed('/cashier'),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.pink[800]),
            title: const Text('Pengaturan'),
            onTap: () => Get.toNamed('/settings'),
          ),
        ],
      ),
    );
  }
}
