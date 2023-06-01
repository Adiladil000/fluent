import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import '../login/view_model/login_view_model.dart';
import 'custom_list_tile_for_drawer.dart';

class ListViewForDriwer extends StatefulWidget {
  const ListViewForDriwer({super.key});

  @override
  State<ListViewForDriwer> createState() => _ListViewForDriwerState();
}

class _ListViewForDriwerState extends State<ListViewForDriwer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomListTileForDrawer(
          icon: Icons.add_a_photo_outlined,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/uploadImage");
          },
          text: TextConstants.uploadImage,
        ),
        CustomListTileForDrawer(
            icon: Icons.logout_rounded,
            onTap: () {
              setState(() {
                Navigator.pop(context);
                LoginViewModel().logout(context);
              });
            },
            text: TextConstants.loguotforDrawer)
      ],
    );
  }
}
