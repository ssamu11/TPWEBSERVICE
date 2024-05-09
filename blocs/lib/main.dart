import 'package:flutter/material.dart';

// Model untuk representasi data skin
class Skin {
  final String name;
  final int price;
  final String imageUrl;

  Skin({required this.name, required this.price, required this.imageUrl});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Skins',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SkinListPage(),
    );
  }
}

class SkinListPage extends StatelessWidget {
  // Dummy data skins
  final List<Skin> skins = [
    Skin(name: "AK-47 | Redline", price: 5000, imageUrl: "assets/images/howl.png"),
    Skin(name: "AWP | Dragon Lore", price: 6000, imageUrl: "assets/images/howl.png"),
    Skin(name: "M4A4 | Howl", price: 5500, imageUrl: "assets/images/howl.png"),
    // Add more skins if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Skins'),
        backgroundColor: Colors.purple[200],
      ),
      body: GridView.builder(
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
          Image.network(
            skin.imageUrl,
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
                Text("Price: ${skin.price}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
