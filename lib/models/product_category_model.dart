import 'dart:convert';

List<ProductCategoryModel> productCategoryModelFromMap(String str) =>
    List<ProductCategoryModel>.from(
        json.decode(str).map((x) => ProductCategoryModel.fromMap(x)));

class ProductCategoryModel {
  final String slug;
  final String name;
  final String url;

  ProductCategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory ProductCategoryModel.fromMap(Map<String, dynamic> json) =>
      ProductCategoryModel(
        slug: json['slug'],
        name: json['name'],
        url: json['url'],
      );
}
