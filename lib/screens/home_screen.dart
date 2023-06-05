import 'dart:convert';
import 'dart:typed_data';

import 'package:fluent/constants/color_constants.dart';
import 'package:fluent/constants/text_constants.dart';
import 'package:fluent/paths/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/list_view_for_driwer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imageFromApi;
  Uint8List? img;
  String? profileImage;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> getImageFromApi() async {
    final response = await http.get(Uri.parse("${TextConstants.mockBaseUrl}/users"));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        isLoading = false;

        imageFromApi = jsonResponse[1]['profileImage'];
      });
      if (imageFromApi == null) return;

      img = base64Decode(imageFromApi.toString());
      return jsonResponse;
    } else {
      return;
    }
  }

  Future<void> patchImageToApi() async {
    final XFile? image = await _picker.pickImage(maxHeight: 480, maxWidth: 640, imageQuality: 70, source: ImageSource.gallery);
    if (image == null) return;

    final imageAsByte = await image.readAsBytes();
    profileImage = base64Encode(imageAsByte);
    if (profileImage == null) return;

    final response = await http.patch(
        Uri.parse(
          "${TextConstants.mockBaseUrl}/users/2",
        ),
        body: {
          'profileImage': profileImage,
        });
    setState(() {
      isLoading = true;
    });
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata == null) {
        print(jsondata['msg']);
      } else {
        print("Upload successful");
      }
    }
    await getImageFromApi();
  }

  @override
  void initState() {
    getImageFromApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorContants.backgroundColor,
        drawer: Drawer(
          elevation: 1,
          backgroundColor: Colors.transparent.withOpacity(0.2),
          child: const Padding(
            padding: EdgeInsets.only(left: 15, top: 30),
            child: ListViewForDriwer(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: ColorContants.backgroundColor,
        ),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    radius: 67,
                    backgroundImage: img == null ? AssetImage(ImagePaths.emptyProfileImage) : MemoryImage(img!) as ImageProvider,
                    child: isLoading == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : null),
              ),
              ElevatedButton(
                  onPressed: () {
                    patchImageToApi();
                  },
                  child: const Text("Update Profile Image")),
              const Divider(height: 10),
            ],
          ),
        ));
  }
}
 




















// import 'package:fluent/constants/color_constants.dart';
// import 'package:flutter/material.dart';

// import '../widgets/list_view_for_driwer.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorContants.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: ColorContants.backgroundColor,
//       ),
//       body: const Center(
//         child: Text('Home Screen'),
//       ),
//       drawer: Drawer(
//         elevation: 1,
//         backgroundColor: Colors.transparent.withOpacity(0.2),
//         child: const Padding(
//           padding: EdgeInsets.only(left: 15, top: 30),
//           child: ListViewForDriwer(),
//         ),
//       ),
//     );
//   }
// }
