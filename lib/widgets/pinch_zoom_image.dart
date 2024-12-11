import 'package:flutter/material.dart';

class PinchZoomImage extends StatelessWidget {
  const PinchZoomImage({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: true, // Allow panning.
      minScale: 1.0, // Minimum zoom scale.
      maxScale: 4.0, // Maximum zoom scale.
      child: Image.network(
        imgUrl,
        // Replace with your image URL or asset.
        fit: BoxFit.contain,
      ),
    );
  }
}
