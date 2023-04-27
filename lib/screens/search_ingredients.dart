import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marc_project/screens/cart.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';
import '../repositories/autocomplete_products_repositories.dart';
import '../widgets/bottom_navbar.dart';

class SearchIngredients extends StatefulWidget {
  const SearchIngredients({super.key});

  @override
  State<SearchIngredients> createState() => _SearchIngredientsState();
}

class _SearchIngredientsState extends State<SearchIngredients> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  List<String> _ingredients = [];

  void _onTextChanged(String value) {
    if (value.isNotEmpty) {
      fetchIngredients(value).then((ingredients) {
        setState(() {
          _ingredients = ingredients;
        });
      });
    } else {
      setState(() {
        _ingredients = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants().primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Header(),
        actions: const <Widget>[
          HeaderCart()
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _textController,
                  onChanged: _onTextChanged,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    hintText: 'Lait, fraise, viande...',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              if (_ingredients.isNotEmpty)
                Card(
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _ingredients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_ingredients[index]),
                          onTap: () {
                            _textController.text = _ingredients[index];
                            setState(() {
                              _ingredients = [];
                            });
                            _focusNode.requestFocus();
                          },
                        );
                      },
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      bottomNavigationBar: const ButtomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScanInfo()));
        },
        elevation: 5,
        backgroundColor: Colors.red,
        child: SvgPicture.asset(
          'assets/scan.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
