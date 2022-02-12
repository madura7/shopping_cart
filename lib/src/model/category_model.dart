import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  late String value;
  late Color color;

  CategoryModel({
    required this.value,
    required this.color,
  });
}

List<CategoryModel> categoryList = List<CategoryModel>.empty(growable: true);
