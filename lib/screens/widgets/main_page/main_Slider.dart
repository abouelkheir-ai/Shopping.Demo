import 'package:carousel_slider/carousel_slider.dart';
import 'package:fake_api/model/products.dart';
import 'package:fake_api/screens/product_details_screen/product_details.dart';
import 'package:flutter/material.dart';


class MainSlider extends StatelessWidget {
  const MainSlider({super.key, required this.productsList});
  final List<Products> productsList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 300.0,
          autoPlay: true,
        ),
        items: productsList.map(
          (product) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ProductDetails(product: product)));
                    },
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
