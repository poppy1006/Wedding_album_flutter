import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryScreenApi extends StatefulWidget {
  const GalleryScreenApi({super.key});

  @override
  State<GalleryScreenApi> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreenApi> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final url = Uri.parse('https://picsum.photos/v2/list?page=2&limit=20');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        imageUrls = data.map((img) => img['download_url'] as String).toList();
      });
    } else {
      print("Failed to fetch images");
    }
  }

  Future<void> downloadImage(String imageUrl, int imageNumber) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final Uint8List imageData = response.bodyBytes;

      final blob = html.Blob([imageData]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "image_$imageNumber.jpg")
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Downloadable Gallery")),
      body: imageUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                            height: 150,
                            child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.download, color: Colors.white),
                          onPressed: () => downloadImage(imageUrl, index + 1),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
