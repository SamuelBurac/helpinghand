import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class CropPic extends StatefulWidget {
  final File imageFile;

  const CropPic({super.key, required this.imageFile});

  @override
  _CropPicState createState() => _CropPicState();
}

class _CropPicState extends State<CropPic> {
  File? _croppedImage;

  @override
  void initState() {
    super.initState();
    _cropImage(widget.imageFile);
  }

  Future<void> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile Picture'),
      ),
      body: Column(
        children: [
          _croppedImage == null
              ? CircularProgressIndicator()
              : Image.file(_croppedImage!),
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.deepOrangeAccent),
                    ),
                    onPressed: () => _cropImage(widget.imageFile),
                    label: Text("Crop"),
                    icon: Icon(Icons.crop)),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(_croppedImage);
                    },
                    label: Text("Save"),
                    icon: Icon(Icons.check)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
