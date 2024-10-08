import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Downloadable Gallery")),
      body: MasonryGridView.builder(
        itemCount: 7,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Image.asset('assets/images/${index + 1}.jpg'),
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    // Construct the file path for the asset image
                    String imagePath = 'assets/images/${index + 1}.jpg';
                    await downloadImage(imagePath, index + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> downloadImage(String assetPath, int imageNumber) async {
    try {
      // Load image data as bytes from the assets folder
      final ByteData bytes = await rootBundle.load(assetPath);

      // Convert the bytes to Uint8List for web download
      final Uint8List imageData = bytes.buffer.asUint8List();

      // Create a Blob from the image data
      final blob = html.Blob([imageData]);

      // Create an object URL for the blob
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create an anchor element to trigger the download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "image_$imageNumber.jpg")
        ..click();

      // Revoke the object URL after download
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}
