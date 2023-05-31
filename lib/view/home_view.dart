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
  Uint8List? SEKIL;
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

    setState(() {
      bytesImage = const Base64Decoder().convert(baseEncode);

      SEKIL = bytesImage;
      preferences.setString("baseEncode", baseEncode);
    });
  }

  void getUserImage() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      baseEncode = preferences.getString("baseEncode") ?? "";
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
            SEKIL != null
                ? Image.memory(
                    width: 200,
                    height: 200,
                    SEKIL!,
                  )
                : const SizedBox(),
            context.emptySizedHeightBoxLow3x,
            ElevatedButton(
                onPressed: () {
                  print(SEKIL);
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
