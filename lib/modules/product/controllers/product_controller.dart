import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tezda_app/models/product_category_model.dart';
import 'package:tezda_app/models/product_model.dart';
import 'package:tezda_app/modules/profile/controllers/profile_controller.dart';
import 'package:tezda_app/utils/locator.dart';

class ProductController extends GetxController {
  int skip = 0;
  int total = 0;
  final scrollController = ScrollController();
  final _loading = false.obs;
  final _loadingMore = false.obs;

  bool get loading => _loading.value;

  bool get loadingMore => _loadingMore.value;

  final categories = <ProductCategoryModel>[].obs;
  final products = <Product>[].obs;

  final filter = <String, String>{}.obs;
  String category = 'All';

  String get categorySlug =>
      categories.firstWhere((e) => e.name == category).slug;
  final _search = ''.obs;

  TextEditingController searchController = TextEditingController();
  String get search => _search.value;

  set search(String val) => _search.value = val;

  Future<void> getCategories() async {
    try {
      final res = await api.getProductCategories();
      categories.assignAll(res);
      categories.sort((a, b) => a.slug.length.compareTo(b.slug.length));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProducts() async {
    final params = {'limit': '20', 'skip': '0'};
    params.addAll(refinedFilter);

    try {
      _loading.value = true;
      final res = await api.getProducts(params);
      products.assignAll(res.products);
      total = res.total;
      skip = res.skip;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading.value = false;
    }
  }

  Future<void> getProductsByCategory() async {
    final params = {'limit': '20', 'skip': '0'};
    params.addAll(refinedFilter);
    try {
      _loading.value = true;
      final res = await api.getProductsByCategory(categorySlug, params);
      products.assignAll(res.products);
      total = res.total;
      skip = res.skip;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading.value = false;
    }
  }

  Future<void> searchProduct(String value) async {
    final params = {'limit': '20', 'skip': '0', 'q': value};
    params.addAll(refinedFilter);
    try {
      _loading.value = true;
      final res = await api.searchProducts(params);
      products.assignAll(res.products);
      total = res.total;
      skip = res.skip;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loading.value = false;
    }
  }

  Future<void> getMoreProducts() async {
    if (loadingMore) return;
    if (products.length >= total) return;
    final params = {'limit': '20', 'skip': '${skip + 20}'};
    params.addAll(refinedFilter);
    try {
      _loadingMore.value = true;
      ProductModel res;
      if (search.isNotEmpty) {
        params['q'] = search;
        res = await api.searchProducts(params);
      } else if (category != 'All') {
        res = await api.getProductsByCategory(categorySlug, params);
      } else {
        res = await api.getProducts(params);
      }
      products.addAll(res.products);
      total = res.total;
      skip = res.skip;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _loadingMore.value = false;
    }
  }

  Map<String, String> get refinedFilter {
    final a = filter;
    if (a.containsValue('Ascending')) {
      a['order'] = 'asc';
    }
    if (a.containsValue('Descending')) {
      a['order'] = 'desc';
    }
    if (a.containsKey('sortBy')) {
      a['sortBy'] = a['sortBy']!.toLowerCase();
    }
    return a;
  }

  @override
  void onReady() {
    super.onReady();
    Get.put(ProfileController());
    getCategories();
    getProducts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent / 1.5)) {
        getMoreProducts();
      }
    });
  }
}
