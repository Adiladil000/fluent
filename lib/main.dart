import 'package:fluent/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/view/login_view.dart';
import 'login/view_model/login_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel()..checkLoginStatus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<LoginViewModel>(
                builder: (context, loginViewModel, _) {
                  if (loginViewModel.isLoggedIn) {
                    return const HomeView();
                  } else {
                    return const LoginView();
                  }
                },
              ),
          '/home': (context) => const HomeView(),
          '/login': (context) => const LoginView(),
        },
      ),
    );
  }
}
