import 'package:fake_api/model/products.dart';
import 'package:fake_api/screens/widgets/main_page/main_Slider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  late Future<List<Products>> _topFiveProducts;
  @override
  void initState() {
    super.initState();
    _topFiveProducts = _getTopFive();
  }

  Future<List<Products>> _getTopFive() async {
    Uri url = Uri.https('fakestoreapi.com', 'products', {'limit': '5'});
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final List jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse.isNotEmpty) {
        final List<Products> productList = jsonResponse
            .map((jsonProduct) => Products.fromJson(jsonProduct))
            .toList();
        return productList;
      } else {
        throw Exception('');
      }
    } else {
      throw Exception('');
    }
  }

  Widget _builder(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      List<Products> productsList = snapshot.data as List<Products>;
      return MainSlider(productsList: productsList);
    }  else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _topFiveProducts,
      builder: _builder,
    );
  }
}
