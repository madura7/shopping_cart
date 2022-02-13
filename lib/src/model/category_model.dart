import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel extends ChangeNotifier {
  late String value;
  late Color color;

  CategoryModel({
    required this.value,
    required this.color,
  });
}

List<CategoryModel> categoryList = List<CategoryModel>.empty(growable: true);

class CategoryNotifierModel with ChangeNotifier {
  String _category = "";
  String get category => _category;
  void changeCategory(String value) {
    _category = _category == value ? "" : value;
    notifyListeners();
  }
}
