import 'package:flutter/material.dart';
import 'package:news/models/catigory_model.dart';
import 'package:news/views/catigory_view.dart';
import 'package:news/widgets/catigory_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  final List<CategoryModel> categories = const [
    CategoryModel(
      image: 'assets/images/business.jpg',
      categoryName: 'Business',
    ),
    CategoryModel(
      image: 'assets/images/entertaiment.jpg',
      categoryName: 'Entertainment',
    ),
    CategoryModel(
      image: 'assets/images/health.jpg',
      categoryName: 'Health',
    ),
    CategoryModel(
      image: 'assets/images/science.jpg',
      categoryName: 'Science',
    ),
    CategoryModel(
      image: 'assets/images/sports.jpg',
      categoryName: 'Sports',
    ),
    CategoryModel(
      image: 'assets/images/technology.jpeg',
      categoryName: 'Technology',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categories[index],
            );
          }),
    );
  }
}
