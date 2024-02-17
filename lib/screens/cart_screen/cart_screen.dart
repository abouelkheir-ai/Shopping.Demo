import 'package:fake_api/model/products.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart(
      {super.key, required this.favProducts, required this.amountRequired});
  final List<Products> favProducts;
  final int amountRequired;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(favProducts[index].title),
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(favProducts[index].image),
                  ),
                  trailing: Text(
                    "${amountRequired}",
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Check out'),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
