import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'dart:io';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        onMediaTap: (mediaCapture) => _handleMediaCapture(context, mediaCapture),
        bottomActionsBuilder: (state) {
          return AwesomeBottomActions(
            state: state,
            onMediaTap: (mediaCapture) => _handleMediaCapture(context, mediaCapture),
          );
        },
      ),
    );
  }

  void _handleMediaCapture(BuildContext context, MediaCapture mediaCapture) {
    if (mediaCapture.status == MediaCaptureStatus.success) {
      final path = mediaCapture.captureRequest.path;
      if (path != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewPage(imagePath: path),
          ),
        );
      }
    }
  }
}

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(File(imagePath), fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Retake'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Pop PreviewPage
                    Navigator.pop(context, File(imagePath)); // Pop CameraPage and return image
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Confirm'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}