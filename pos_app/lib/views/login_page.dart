import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to POS System',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Please login to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink[600],
              ),
            ),
            SizedBox(height: 48),
            TextField(
              controller: _controller.usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 24),
            Obx(() => TextField(
                  controller: _controller.passwordController,
                  obscureText: _controller.isObscured.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _controller.isObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.pink[800],
                      ),
                      onPressed: _controller.toggleObscure,
                    ),
                  ),
                )),
            SizedBox(height: 24),
            Obx(() {
              if (_controller.errorMessage.isNotEmpty) {
                return Container(
                  color: Colors.red[300],
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _controller.errorMessage.value,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            }),
            ElevatedButton(
              onPressed: _controller.login,
              child: Text('Login'),
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
