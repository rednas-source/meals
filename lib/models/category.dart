import 'package:flutter/material.dart';
//represents a category with ID title and color
class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  /// Unique identifier for the category.
  final String id;
  /// Display name of the category.
  final String title;
  /// Color associated with the category.
  final Color color;
}
