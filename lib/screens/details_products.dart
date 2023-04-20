import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Map<String, dynamic> _productDetails = {};

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  void _fetchProductDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/food/ingredients/${widget.productId}/information?amount=1'));

    if (response.statusCode == 200) {
      setState(() {
        _productDetails = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to fetch product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _productDetails['image'] ?? "",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              _productDetails['name'] ?? "",
              style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontSize: 20,
                color: Constants().textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${_productDetails['description'] ?? ""}',
              style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontSize: 16,
                color: Constants().textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Ingredients: ${_productDetails['ingredients']?.join(', ') ?? ""}',
              style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontSize: 16,
                color: Constants().textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
