import 'package:get/get.dart';
import 'package:pos_app/services/api_service.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var errorMessage = ''.obs;
  var isObscured = true.obs;

  void toggleObscure() {
    isObscured.value = !isObscured.value;
  }

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = 'Username and password cannot be empty';
      return;
    }

    try {
      final apiService = ApiService();
      final response = await apiService.login(username, password);

      if (response['status'] == 'success') {
        Get.offAllNamed('/dashboard');
      } else {
        errorMessage.value = response['message'] ?? 'Login failed';
      }
    } catch (error) {
      errorMessage.value = 'An error occurred, please try again';
    }
  }
}
