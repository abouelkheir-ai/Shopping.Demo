import 'package:fake_api/model/products.dart';
import 'package:fake_api/screens/widgets/product_item/image_header.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key, required this.product, required this.showProductDetails});
  final Products product;
  final Function() showProductDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showProductDetails,
      child: Card(
        child: Stack(
          children: [
            FadeInImage(
              width: double.infinity,
              height: 200,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(product.image),
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageHeader(
                            icon: Icons.attach_money,
                            title: "${product.price}",
                            color: Colors.green),
                        ImageHeader(
                            icon: Icons.star,
                            title: " ${product.rating["rate"]}",
                            color: Colors.yellow),
                        ImageHeader(
                            icon: Icons.inventory,
                            title: " ${product.rating["count"]}",
                            color: Colors.blueGrey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
