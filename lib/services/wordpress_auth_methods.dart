import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/databases/boxes.dart';
import '../constants.dart';
import '../databases/securestorage.dart';
import '../models/user_model.dart';

class WordpressAuthMethods {
  final String _wpApiPath = 'wp-json/jwt-auth/v1/';
  final String _wpTokenPath = 'token';
  // final String _wpTokenValidatePath = 'token/validate';
  // final String _wpRegisterPath = 'register';
  final Dio _dio = Dio();
  final box = Boxes.getUser();

  Future<bool> loginToWordPress(
      context, String username, String password) async {
    try {
      final response = await _dio.post(
        baseUrl + _wpApiPath + _wpTokenPath,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        UserModel user = UserModel(
          token: token,
          userId: response.data['user_id'],
          userEmail: response.data['user_email'],
          userNicename: response.data['user_nicename'],
          userDisplayName: response.data['user_display_name'],
          userRole: response.data['user_role'],
        );

        // Save token to secure storage
        await SecureStorage.saveToken(token);

        // Save user to usersbox
        box.put(1, user);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ),
        );

        // return true
        return true;
      } else {
        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
            backgroundColor: Colors.red,
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ),
        );
        // return false
      }
      return false;
    } catch (error) {
      print(error);
      // show error message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Username or password is incorrect'),
      //     backgroundColor: Colors.red,
      //   ),
      // );

      // return false
      return false;
    }
  }

  Future<void> registertoWoocommerce(
      String username, String email, String password) async {
    await wcApi.postAsync(
      "customers",
      {
        "username": username,
        "email": email,
        "password": password,
      },
    );
    // userDatabase
    //     .add({"userEmail": email, "userId": email, "userRole": username});
  }

  Future<bool> checkUserExistence(String usernameOrEmail) async {
    try {
      final response = await _dio.get(
        '${baseUrl}wp-json/wc/v3/customers',
        queryParameters: {'search': usernameOrEmail},
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> customers = response.data;

        // Check if any customer data matches the provided username or email
        return customers.any((customer) =>
            customer['username'] == usernameOrEmail ||
            customer['email'] == usernameOrEmail);
      } else {
        throw Exception('Failed to fetch customer data');
      }
    } catch (error) {
      throw Exception('Failed to fetch customer data: $error');
    }
  }

  Future<void> clearUser() async {
    await SecureStorage.deleteToken();
    if (box.isNotEmpty) {
      await box.deleteAt(0);
    }
  }
}
