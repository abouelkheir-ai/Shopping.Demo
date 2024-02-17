import 'package:fake_api/model/products.dart';
import 'package:fake_api/screens/product_details_screen/product_details.dart';
import 'package:fake_api/screens/widgets/product_item/product_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.categoryTitle});
  final String categoryTitle;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Products>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = _getFilteredProducts(widget.categoryTitle);
  }

  Future<List<Products>> _getFilteredProducts(String categoryName) async {
    Uri url = Uri.https('fakestoreapi.com', 'products/category/$categoryName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse.isNotEmpty) {
        final List<Products> categoriesName =
            jsonResponse.map((name) => Products.fromJson(name)).toList();
        return categoriesName;
      } else {
        throw Exception('');
      }
    } else {
      throw Exception('');
    }
  }

  Widget _builder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      final List<Products> products = snapshot.data;
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(
            product: products[index],
            showProductDetails: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ProductDetails(
                  product: products[index],
                ),
              ));
            },
          );
        },
      );
    } else {
      return const Text('No data available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
      ),
      body: FutureBuilder(future: _filteredProducts, builder: _builder),
    );
  }
}
