import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Laptop', price: 90.0),
    Product(name: 'Mobile', price: 70.0),
    Product(name: 'Watch', price: 30.0),
    Product(name: 'Monitor', price: 40.0),
    Product(name: 'Headphone', price: 20.0),
    Product(name: 'Keyboard', price: 10.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(5)}'),
            trailing: CounterButton(
              product: products[index],
              onCounterUpdated: (product) {
                if (product.counter == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You\'ve bought 5 ${product.name}!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),




      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CounterButton extends StatefulWidget {
  final Product product;
  final Function(Product) onCounterUpdated;

  CounterButton({required this.product, required this.onCounterUpdated});

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Text(widget.product.counter.toString()),
        SizedBox(width: 9.0),

        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.product.incrementCounter();
              widget.onCounterUpdated(widget.product);
            });
          },
          child: Text('Buy Now'),
        ),
      ],
    );
  }
}

class Product {
  String name;
  double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});

  void incrementCounter() {
    counter++;
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  int getTotalBoughtProducts() {
    int total = 0;
    for (var product in products) {
      total += product.counter;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Bought Products: ${getTotalBoughtProducts()}'),
      ),
    );
  }
}