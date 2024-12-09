import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text('Transaction History', style: TextStyle(fontFamily: 'Times New Roman')),
      ),
      body: Center(
        child: Text(
          'Transaction History Content Here',
          style: TextStyle(fontSize: 24, fontFamily: 'Times New Roman'),
        ),
      ),
    );
  }
}
