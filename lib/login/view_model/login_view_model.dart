import 'dart:convert';

import 'package:fluent/login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/text_constants.dart';

class LoginViewModel with ChangeNotifier {
//  eve.holt@reqres.in
//  cityslicka

  String? _token;
  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> signIn(context, LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse("${TextConstants.baseUrl}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': loginModel.email,
        'password': loginModel.password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _token = jsonData['token'];
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', _token!);
      print(_token);

      await Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('error');
    }
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('token');

    notifyListeners();
  }

  Future<void> logout(context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
    _token = null;

    await preferences.remove('accountImageAsBase64');

    await Navigator.pushReplacementNamed(context, '/login');

    notifyListeners();
  }
}
