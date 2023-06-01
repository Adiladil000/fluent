import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomListTileForDrawer extends StatelessWidget {
  const CustomListTileForDrawer({
    required this.icon,
    required this.onTap,
    required this.text,
    super.key,
  });

  final IconData icon;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          context.emptySizedWidthBoxNormal,
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
