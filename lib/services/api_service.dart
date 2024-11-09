import 'dart:convert';

import 'package:tezda_app/models/login_model.dart';
import 'package:tezda_app/models/product_category_model.dart';
import 'package:tezda_app/models/product_model.dart';
import 'package:tezda_app/models/user_model.dart';
import 'package:tezda_app/services/http_client.dart';

class ApiService {
  final HttpClientWrapper _http = HttpClientWrapper();

  Future<UserModel> registerUser(dynamic body) async {
    final response =
        await _http.post('https://api.escuelajs.co/api/v1/users/', body: body);
    String data = jsonEncode(response.body);
    return userModelFromMap(data);
  }

  Future<LoginModel> loginUser(dynamic body) async {
    final response = await _http
        .post('https://api.escuelajs.co/api/v1/auth/login', body: body);
    String data = jsonEncode(response.body);
    return loginModelFromMap(data);
  }

  Future<List<ProductCategoryModel>> getProductCategories() async {
    final response =
        await _http.get('https://dummyjson.com/products/categories');
    String data = jsonEncode(response.body);
    return productCategoryModelFromMap(data);
  }

  Future<ProductModel> getProducts(Map<String, String> params) async {
    final response =
        await _http.get('https://dummyjson.com/products', queryParams: params);
    String data = jsonEncode(response.body);
    return productModelFromMap(data);
  }

  Future<ProductModel> getProductsByCategory(
      String category, Map<String, String> params) async {
    final response = await _http.get(
        'https://dummyjson.com/products/category/$category',
        queryParams: params);
    String data = jsonEncode(response.body);
    return productModelFromMap(data);
  }

  Future<ProductModel> searchProducts(Map<String, String> params) async {
    final response = await _http.get('https://dummyjson.com/products/search',
        queryParams: params);
    String data = jsonEncode(response.body);
    return productModelFromMap(data);
  }

  Future<UserModel> getProfile(String token) async {
    final response = await _http
        .get('https://api.escuelajs.co/api/v1/auth/profile', token: token);
    if (!response.success) {
      throw Exception(response.message);
    }
    String data = jsonEncode(response.body);
    return userModelFromMap(data);
  }

  Future<UserModel> updateProfile(dynamic body, String id) async {
    final response = await _http
        .put('https://api.escuelajs.co/api/v1/users/$id', body: body);
    String data = jsonEncode(response.body);
    return userModelFromMap(data);
  }
}
