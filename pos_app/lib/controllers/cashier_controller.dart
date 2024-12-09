import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/services/api_service.dart';

class CashierController extends GetxController {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  var products = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;

  final ApiService _apiService = ApiService();

  void logout() {
    Get.offAllNamed('/login');
  }

  void addProduct() {
    final productName = productNameController.text;
    final productPrice = double.tryParse(productPriceController.text) ?? 0.0;

    if (productName.isNotEmpty && productPrice > 0) {
      Map<String, dynamic> product = {
        'name': productName,
        'price': productPrice,
      };
      products.add(product);
      totalPrice.value += productPrice;

      productNameController.clear();
      productPriceController.clear();
    } else {
      Get.snackbar(
        'Error',
        'Product name and price cannot be empty or zero.',
        backgroundColor: Colors.pink[200],
      );
    }
  }

  void editProduct(int index) {
    final product = products[index];
    productNameController.text = product['name'];
    productPriceController.text = product['price'].toString();
    totalPrice.value -= product['price'];
    products.removeAt(index);
  }

  void removeProduct(int index) {
    final productPrice = products[index]['price'];
    totalPrice.value -= productPrice;
    products.removeAt(index);
  }

  void completeTransaction() {
    Get.snackbar(
      'Processing',
      'Submitting your transaction...',
      backgroundColor: Colors.pink[200],
    );

    List<Map<String, dynamic>> transactionProducts = products.map((product) {
      return {
        'name': product['name'],
        'price': product['price'],
      };
    }).toList();

    _apiService.completeTransaction(transactionProducts).then((response) {
      if (response['status'] == 'success') {
        Get.snackbar('Success', 'Transaction completed successfully!');
      } else {
        Get.snackbar('Error', 'Failed to complete transaction.');
      }
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to complete transaction.');
    });

    products.clear();
    totalPrice.value = 0.0;
  }
}
