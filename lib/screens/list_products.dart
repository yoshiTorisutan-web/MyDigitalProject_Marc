import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final url = Uri.parse(
        'https://api.spoonacular.com/food/products/search?apiKey=e7d8103d0f674050924ec567074b3e0a&query=fruit');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      _products = data['products'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits et légumes'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              _products[index]['image'],
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
            title: Text(_products[index]['title']),
          );
        },
      ),
    );
  }
}
