import 'package:fluent/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../widgets/list_view_for_driwer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorContants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorContants.backgroundColor,
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
      drawer: Drawer(
        elevation: 1,
        backgroundColor: Colors.transparent.withOpacity(0.2),
        child: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: ListViewForDriwer(),
        ),
      ),
    );
  }
}
