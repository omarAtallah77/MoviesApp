import 'package:flutter/material.dart';

import '../screens/image_viewer_screen.dart';

Widget alignLeft(String text) => Align(
  alignment: Alignment.centerLeft,
  child: Text(
    text,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.grey[800],
    ),
  ),
);

Widget imageitem(BuildContext context, String url) => GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ImageViewerScreen(imageUrl: url)),
    );
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(url, width: 110, height: 160, fit: BoxFit.cover),
  ),
);

Widget custuizedtetfield(double? textize, String? text) => Text(
  text ?? "",
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: textize, fontWeight: FontWeight.bold),
);
