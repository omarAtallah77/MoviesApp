import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveImageToGallery(String url, BuildContext context) async {
  try {
    // Request permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    // Get the directory to save (Pictures folder)
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory(
        '/storage/emulated/0/Pictures/MyApp',
      ); // Public folder
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
    } else {
      directory = await getApplicationDocumentsDirectory(); // iOS
    }

    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Download the image
    await Dio().download(url, filePath);

    // On Android, notify media scanner so the image appears in Gallery
    if (Platform.isAndroid) {
      final result = await Process.run('am', [
        'broadcast',
        '-a',
        'android.intent.action.MEDIA_SCANNER_SCAN_FILE',
        '-d',
        'file://$filePath',
      ]);
      print(result.stdout);
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Image saved successfully!')));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error saving image: $e')));
  }
}
