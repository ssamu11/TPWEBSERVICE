import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List skin',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EmployeeListPage(),
    );
  }
}

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  late List<Skin> skins = []; // Initialize skins as an empty list

  Future<void> fetchSkins() async {
    final response = await http.get(Uri.parse('http://localhost:8000/skins/'));
    if (response.statusCode == 200) {
      setState(() {
        skins = List<Skin>.from(json.decode(response.body).map((x) => Skin.fromJson(x)));
      });
    } else {
      throw Exception('Failed to load skins');
    }
  }

  @override
  void initState() {
    fetchSkins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List skin'),
        backgroundColor: Colors.purple[200],
      ),
      body: skins.isEmpty // Check if skins is empty before accessing it
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: skins.length,
              itemBuilder: (context, index) {
                final skin = skins[index];
                return SkinCard(skin: skin);
              },
            ),
    );
  }
}

class SkinCard extends StatelessWidget {
  final Skin skin;

  SkinCard({required this.skin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            '../assets/images/${skin.image_url}',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skin.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Harga: ${skin.price_idr}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Skin {
  final String name;
  final String image_url;
  final int price_idr;

  Skin({
    required this.name,
    required this.image_url,
    required this.price_idr,
  });

  factory Skin.fromJson(Map<String, dynamic> json) {
    return Skin(
      name: json['name'],
      image_url: json['image_url'],
      price_idr: json['price_idr'],
    );
  }
}
