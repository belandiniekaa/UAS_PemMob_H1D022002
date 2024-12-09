import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.50.140/pos_app_backend/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}login.php'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        if (result['status'] == 'success') {
          return result;
        } else {
          throw Exception(result['message'] ?? 'Login failed');
        }
      } else {
        throw Exception(
            'Login failed. Status code: ${response.statusCode}. Body: ${response.body}');
      }
    } catch (e) {
      print('Login Error: $e');
      return {
        'success': false,
        'message': 'An error occurred, please try again later.'
      };
    }
  }

  Future<Map<String, dynamic>> getSalesData() async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}get_summary.php'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        return result;
      } else {
        throw Exception(
            'Failed to fetch sales data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Sales Data Error: $e');
      return {
        'success': false,
        'message': 'An error occurred while fetching sales data.'
      };
    }
  }

  Future<Map<String, dynamic>> addProduct(String name, double price) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}add_product.php'),
        body: jsonEncode({'name': name, 'price': price}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to add product. Status code: ${response.statusCode}. Body: ${response.body}');
      }
    } catch (e) {
      print('Add Product Error: $e');
      return {
        'status': 'error',
        'message': 'An error occurred while adding the product.'
      };
    }
  }

  Future<Map<String, dynamic>> completeTransaction(
      List<Map<String, dynamic>> products) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}add_transaction.php'),
        body: json.encode({'products': products}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to complete transaction');
      }
    } catch (e) {
      print('Error: $e');
      return {
        'status': 'error',
        'message': 'Error occurred during the transaction'
      };
    }
  }
}
