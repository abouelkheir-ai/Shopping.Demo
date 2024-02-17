import 'package:fake_api/model/products.dart';
import 'package:fake_api/screens/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Products product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _counter = 0;
  int _avaliableAmount = 0;
  final List<Products> favProducts = [];

  void _addItem() {
    if (_counter == _avaliableAmount) {
      return;
    }
    setState(() {
      favProducts.add(widget.product);
      _counter++;
    });
  }

  void _removeItem() {
    if (_counter == 0) {
      return;
    }
    setState(() {
      favProducts.remove(widget.product);
      _counter--;
    });
  }

  String _inStock() => (_avaliableAmount - _counter).toString();

  @override
  void initState() {
    if (widget.product.rating["count"] != null) {
      _avaliableAmount = widget.product.rating["count"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          softWrap: true,
          style: const TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      final List<Products> favList = favProducts
                          .map((product) => product)
                          .toSet()
                          .toList();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => Cart(
                            favProducts: favList,
                            amountRequired: _counter,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined)),
                Text(
                  "$_counter",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Image.network(
                widget.product.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.product.description,
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Avaliable Amount:',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(_inStock()),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: _removeItem,
                          icon: const Icon(Icons.remove)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("$_counter"),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: _addItem,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
