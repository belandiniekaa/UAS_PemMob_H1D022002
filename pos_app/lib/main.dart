import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/views/login_page.dart';
import 'package:pos_app/views/dashboard_page.dart';
import 'package:pos_app/views/cashier_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS System',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/cashier', page: () => CashierPage()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
