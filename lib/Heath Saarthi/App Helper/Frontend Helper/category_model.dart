import 'package:flutter/material.dart';

class CategoryItem {
  final String imageUrl;
  final String title;

  CategoryItem({required this.imageUrl, required this.title,});
}

List<CategoryItem> categoryItems = [
  CategoryItem(
    imageUrl: 'assets/PNG/icon_1.png',
    title: 'Heart',
  ),
  CategoryItem(
    imageUrl: 'assets/PNG/icon_2.png',
    title: 'Lungs',
  ),
  CategoryItem(
    imageUrl: 'assets/PNG/icon_3.png',
    title: 'Kidneys',
  ),
  CategoryItem(
    imageUrl: 'assets/PNG/icon_4.png',
    title: 'Liver',
  ),
  CategoryItem(
    imageUrl: 'assets/PNG/icon_5.png',
    title: 'Brain',
  ),
  CategoryItem(
    imageUrl: 'assets/PNG/icon_6.png',
    title: 'Decay',
  ),
];
