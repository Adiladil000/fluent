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
  Uint8List? bytesImage;
  String? base64EncodedImage;

  Uint8List? imageBytesFromPref;
  String? encodedBase64FromPref;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageBase64() async {
    final preferences = await SharedPreferences.getInstance();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    base64EncodedImage = base64Encode(await image.readAsBytes());

    setState(() {
      bytesImage = const Base64Decoder().convert(base64EncodedImage!);
      encodedBase64FromPref = base64EncodedImage;
      preferences.setString("base64EncodedImage", base64EncodedImage!);
    });
  }

  Future<void> getImage() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      encodedBase64FromPref = preferences.getString("base64EncodedImage") ?? "";
      imageBytesFromPref = const Base64Decoder().convert(encodedBase64FromPref!);
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
            imageBytesFromPref != null
                ? Image.memory(
                    width: 200,
                    height: 200,
                    imageBytesFromPref!,
                  )
                : const SizedBox(),
            context.emptySizedHeightBoxLow3x,
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _pickImageBase64().whenComplete(() => getImage());
                  });
                },
                child: Text(TextConstants.pickImageFromGallery)),
            context.emptySizedHeightBoxLow3x,
            ElevatedButton(
                onPressed: () {
                  LoginViewModel().logout(context).then((_) {
                    Navigator.pushReplacementNamed(context, "/");
                  });
                },
                child: Text(TextConstants.loguot)),
          ],
        ),
      ),
    );
  }
}
