import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_app/controllers/dashboard_controller.dart';

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
            onPressed: () {
              _controller.fetchSalesData();
            },
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.pink[100],
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.store, size: 40, color: Colors.pink[800]),
                    SizedBox(width: 10),
                    Text(
                      'POS System',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.dashboard, color: Colors.pink[800]),
                title: Text('Dashboard',
                    style: TextStyle(color: Colors.pink[800])),
                onTap: () {
                  Get.toNamed('/dashboard');
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.pink[800]),
                title:
                    Text('Cashier', style: TextStyle(color: Colors.pink[800])),
                onTap: () {
                  Get.toNamed('/cashier');
                  Get.back();
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.pink[800]),
                title:
                    Text('Logout', style: TextStyle(color: Colors.pink[800])),
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
              return Column(
                children: [
                  Row(
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
                                Icon(Icons.monetization_on,
                                    size: 40, color: Colors.pink[800]),
                                SizedBox(height: 8),
                                Text(
                                  'Total Sales',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[800],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${salesSummary['total'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
                                Icon(Icons.receipt,
                                    size: 40, color: Colors.pink[800]),
                                SizedBox(height: 8),
                                Text(
                                  'Transactions',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[800],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${salesSummary['count'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                final salesData = _controller.salesData;

                if (salesData.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart,
                            size: 50, color: Colors.pink[800]),
                        SizedBox(height: 10),
                        Text(
                          'No data available to display.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.pink[800],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) =>
                          FlLine(color: Colors.pink[300], strokeWidth: 1),
                      getDrawingVerticalLine: (value) =>
                          FlLine(color: Colors.pink[300], strokeWidth: 1),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTextStyles: (context, value) =>
                            TextStyle(color: Colors.pink[800], fontSize: 12),
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) =>
                            TextStyle(color: Colors.pink[800], fontSize: 12),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: salesData.entries
                            .map((entry) => FlSpot(
                                  entry.key.toDouble(),
                                  entry.value.toDouble(),
                                ))
                            .toList(),
                        isCurved: true,
                        colors: [Colors.pink[800]!],
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [Colors.pink.withOpacity(0.2)],
                        ),
                        barWidth: 4,
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
