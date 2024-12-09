import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController _controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.pink[800],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _controller.fetchSalesData,
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.pink[100],
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.dashboard, color: Colors.pink[800]),
                title: Text('Dashboard', style: TextStyle(color: Colors.pink[800])),
                onTap: () {
                  Get.toNamed('/dashboard');
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.pink[800]),
                title: Text('Cashier', style: TextStyle(color: Colors.pink[800])),
                onTap: () {
                  _controller.navigateToCashier();
                  Get.back();
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.pink[800]),
                title: Text('Logout', style: TextStyle(color: Colors.pink[800])),
                onTap: _controller.logout,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Obx(() {
              final salesSummary = _controller.salesSummary;
              return Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.pink[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.monetization_on, size: 40, color: Colors.pink[800]),
                            SizedBox(height: 8),
                            Text('Total Sales', style: TextStyle(color: Colors.pink[800])),
                            SizedBox(height: 8),
                            Text('\$${salesSummary['total']}', style: TextStyle(color: Colors.white, fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      color: Colors.pink[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.receipt, size: 40, color: Colors.pink[800]),
                            SizedBox(height: 8),
                            Text('Transactions', style: TextStyle(color: Colors.pink[800])),
                            SizedBox(height: 8),
                            Text('${salesSummary['count']}', style: TextStyle(color: Colors.white, fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final salesData = _controller.salesData;

                if (salesData.isEmpty) {
                  return Center(
                    child: Text('No data available'),
                  );
                }

                return LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: salesData.entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        colors: [Colors.pink[800]!],
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [Colors.pink.withOpacity(0.2)],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
