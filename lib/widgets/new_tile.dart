import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/widgets/build_image_loding.dart';

class NewTile extends StatelessWidget {
  const NewTile({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: BuildImageLoading(
            imageUrl: news.image,
            height: 200,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          news.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          news.subTitle ?? '',
          maxLines: 2,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
