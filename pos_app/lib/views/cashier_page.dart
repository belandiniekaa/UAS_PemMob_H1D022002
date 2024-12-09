import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/cashier_controller.dart';

class CashierPage extends StatelessWidget {
  final CashierController _controller = Get.put(CashierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Cashier'),
        backgroundColor: Colors.pink[800],
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
                child: Text(
                  'POS System',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                  ),
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.pink[200],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller.productNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _controller.productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _controller.addProduct,
                      child: Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[600],
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _controller.products.length,
                  itemBuilder: (context, index) {
                    final product = _controller.products[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.pink[100],
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading:
                            Icon(Icons.shopping_cart, color: Colors.pink[800]),
                        title:
                            Text('${product['name']} - \$${product['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.pink[800]),
                              onPressed: () {
                                _controller.editProduct(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.pink[800]),
                              onPressed: () {
                                _controller.removeProduct(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[800],
                      ),
                    ),
                    Text(
                      '\$${_controller.totalPrice.value}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.pink[800],
                      ),
                    ),
                  ],
                ),
              );
            }),
            ElevatedButton(
              onPressed: _controller.completeTransaction,
              child: Text('Complete Transaction'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[600],
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
