import 'package:fake_api/model/categories.dart';
import 'package:fake_api/screens/product_screen/product_screen.dart';
import 'package:fake_api/screens/widgets/main_page/category_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CategoriesGrid extends StatefulWidget {
  const CategoriesGrid({
    super.key,
  });

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  late Future<List<Categories>> _categoriesName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesName = _getCategoryTitle();
  }

  void _toProducts(BuildContext context, categoryTitle, index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductList(
          categoryTitle: categoryTitle,
        ),
      ),
    );
  }

  Future<List<Categories>> _getCategoryTitle() async {
    Uri url = Uri.https('fakestoreapi.com', 'products/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse.isNotEmpty) {
        final List<Categories> categoriesName =
            jsonResponse.map((name) => Categories.fromJson(name)).toList();
        return categoriesName;
      } else {
        throw Exception('');
      }
    } else {
      throw Exception('');
    }
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      final List<Categories> categories = snapshot.data;
      return Expanded(
        child: GridView.builder(
          itemCount: snapshot.data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 3 / 2,
              crossAxisCount: 2),
          itemBuilder: (ctx, index) => CategoryItem(
            categoryTitle: categories[index].categoryTitles,
            toProducts: () {
              _toProducts(context, categories[index].categoryTitles, index);
            },
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _categoriesName, builder: _builder);
  }
}
