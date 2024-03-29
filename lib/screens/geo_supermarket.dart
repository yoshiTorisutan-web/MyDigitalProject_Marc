import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:marc_project/screens/scan_info.dart';
import 'package:marc_project/widgets/header.dart';
import 'package:marc_project/widgets/header_cart.dart';
import '../constants/constants.dart';
import '../widgets/bottom_navbar.dart';
import 'list_supermarket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Page "Localisation magasin" permet à l'utilsiateur de choisir une ville sur la carte et voir les magasins localisés
//autour de lui afin de choisir le magasin pour effectuer ses courses par la suite.

class SuperMarketGeo extends StatefulWidget {
  const SuperMarketGeo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuperMarketGeoState createState() => _SuperMarketGeoState();
}

class Store {
  final String name;
  final String address;
  final double distance;

  Store(this.name, this.address, this.distance);
}

List<Store> stores = [
  Store("Carrefour", "Rue du Grand Launay, Angers", 2.5),
  Store("Leclerc", "Bd Albert Camus, Angers", 3.1),
  Store("Auchan", "6 Rte nationale, Avrillé", 7.2),
  Store("Super U", "Rue du Bourg de Paille, Beaucouzé", 2.0),
  Store("Lidl", "56 Av. du Général Patton, Angers", 1.5)
];

class _SuperMarketGeoState extends State<SuperMarketGeo> {
//Ajout fonctionnalité recherche de la ville et l'afficher sur une map
  final TextEditingController _textEditingController = TextEditingController();
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() async {
    String cityName = _textEditingController.text;
    String url =
        'https://nominatim.openstreetmap.org/search?format=json&q=$cityName';

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          double latitude = double.parse(data[0]['lat']);
          double longitude = double.parse(data[0]['lon']);

          setState(() {
            _mapController.move(LatLng(latitude, longitude), 13.0);
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erreur lors de la récupération des coordonnées : $e');
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
        actions: const <Widget>[HeaderCart()],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 10,
            right: 10,
            bottom: 1, // reduce the bottom value
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants().secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                            ),
                            child: const Text('Map',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: "RedHatDisplay")),
                          ),
                        ],
                      ),
                    ),
                    Text('Mon magasin',
                        style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                            color: Constants().textColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Beaucouzé, Angers',
                        style: TextStyle(
                            fontFamily: "RedHatDisplay",
                            fontSize: 16,
                            color: Constants().textColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        hintText: 'Rechercher par ville',
                        suffixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Constants().secondaryColor,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        hintStyle: const TextStyle(fontSize: 12),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SizedBox(
                          height: 200.0, // Taille prédéfinie
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              center: LatLng(47.4853511, -0.5757254),
                              zoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(47.4853511, -0.5757254),
                                    builder: (ctx) => Icon(
                                      Icons.shopping_cart,
                                      color: Constants().secondaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(47.466739654541016,
                                        -0.5940532088279724),
                                    builder: (ctx) => Icon(
                                      Icons.shopping_cart,
                                      color: Constants().secondaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(
                                        47.51725387573242, -0.6050036549568176),
                                    builder: (ctx) => Icon(
                                      Icons.shopping_cart,
                                      color: Constants().secondaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(47.474568, -0.6318363),
                                    builder: (ctx) => Icon(
                                      Icons.shopping_cart,
                                      color: Constants().secondaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(
                                        47.47344207763672, -0.5906012058258057),
                                    builder: (ctx) => Icon(
                                      Icons.shopping_cart,
                                      color: Constants().secondaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SupermarketList()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants().secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Trouver mon magasin',
                                  style:
                                      TextStyle(fontFamily: "RedHatDisplay")),
                              Icon(Icons.place),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30)
                      ],
                    )
                  ],
                ),
              ),
            ),
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
