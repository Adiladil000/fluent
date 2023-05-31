import 'dart:convert';
import 'package:fluent/constants/color_constants.dart';
import 'package:fluent/constants/text_constants.dart';
import 'package:fluent/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? userEmail;
  String? baseEncode;
  Uint8List? bytesImage;

  Future<void> getUserImage() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      baseEncode = preferences.getString("baseEncode") ??
          'iVBORw0KGgoAAAANSUhEUgAAADMAAAAzCAYAAAA6oTAqAAAAEXRFWHRTb2Z0d2FyZQBwbmdjcnVzaEB1SfMAAABQSURBVGje7dSxCQBACARB+2/ab8BEeQNhFi6WSYzYLYudDQYGBgYGBgYGBgYGBgYGBgZmcvDqYGBgmhivGQYGBgYGBgYGBgYGBgYGBgbmQw+P/eMrC5UTVAAAAABJRU5ErkJggg==';
    });
  }

  @override
  void initState() {
    getUserImage();
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();

  void _pickImageBase64() async {
    final preferences = await SharedPreferences.getInstance();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    var baseEncode = base64Encode(await image.readAsBytes());
    preferences.setString("key", baseEncode);
    setState(() {
      bytesImage = const Base64Decoder().convert(baseEncode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorContants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bytesImage != null
                ? Image.memory(
                    width: 200,
                    height: 200,
                    bytesImage!,
                  )
                : const SizedBox(),
            context.emptySizedHeightBoxLow3x,
            ElevatedButton(
                onPressed: () {
                  _pickImageBase64();
                },
                child: Text(TextConstants.pickImageFromGallery)),
            context.emptySizedHeightBoxLow3x,
            ElevatedButton(
                onPressed: () {
                  LoginViewModel().logout(context).then((_) {
                    Navigator.pushReplacementNamed(context, "/");
                  });
                },
                child: Text(TextConstants.logot)),
          ],
        ),
      ),
    );
  }
}
