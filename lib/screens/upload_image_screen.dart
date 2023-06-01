import 'dart:convert';
import 'package:fluent/constants/color_constants.dart';
import 'package:fluent/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartal/kartal.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Uint8List? bytesImage;
  String? accountImageAsBase64;

  Uint8List? imageBytesFromPref;
  String? fromPrefAccountImageAsBase64;

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
    final imageAsByte = await image.readAsBytes();
    accountImageAsBase64 = base64Encode(imageAsByte);

    setState(() {
      bytesImage = imageAsByte;
      fromPrefAccountImageAsBase64 = accountImageAsBase64;
      preferences.setString("accountImageAsBase64", accountImageAsBase64!);
    });
  }

  Future<void> getImage() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString("accountImageAsBase64") == null) return;

      try {
        fromPrefAccountImageAsBase64 = preferences.getString("accountImageAsBase64");
        imageBytesFromPref = const Base64Decoder().convert(fromPrefAccountImageAsBase64!);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');

        return true;
      },
      child: Scaffold(
        backgroundColor: ColorContants.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorContants.backgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(color: Colors.white, Icons.arrow_back_outlined)),
        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
