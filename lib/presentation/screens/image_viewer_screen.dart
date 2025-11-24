import 'package:flutter/material.dart';

import '../../core/utils/helper.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl; // full original url

  ImageViewerScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveImageToGallery(imageUrl, context);
            },
          ),
        ],
      ),
      body: Center(child: InteractiveViewer(child: Image.network(imageUrl))),
    );
  }
}
