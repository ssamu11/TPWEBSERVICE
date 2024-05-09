import 'package:flutter/material.dart';
import 'package:blocs/skin_bloc.dart';
import 'package:blocs/skin.dart';

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

class SkinListPage extends StatefulWidget {
  @override
  _SkinListPageState createState() => _SkinListPageState();
}

class _SkinListPageState extends State<SkinListPage> {
  final SkinBloc _skinBloc = SkinBloc();

  @override
  void initState() {
    super.initState();
    _skinBloc.fetchAllSkins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Skins'),
        backgroundColor: Colors.purple[200],
      ),
      body: StreamBuilder<List<Skin>>(
        stream: _skinBloc.allSkins,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final skin = snapshot.data![index];
                // Menampilkan detail skin menggunakan SkinCard
                return SkinCard(skin: skin); // Menggunakan SkinCard di sini
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _skinBloc.dispose();
  }
}

// SkinCard didefinisikan di sini
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
            '../assets/images/${skin.imageUrl}',
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
