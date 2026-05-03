import 'package:flutter/material.dart';

class BuildImageLoading extends StatelessWidget {
  const BuildImageLoading({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  final String? imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            height: height,
            width: width,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 50,
                ),
              );
            },
          )
        : Container(
            height: height,
            width: width,
            color: Colors.grey[300],
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: 50,
            ),
          );
  }
}
