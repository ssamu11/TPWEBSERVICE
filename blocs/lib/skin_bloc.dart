import 'dart:convert';
import 'dart:async'; // Import for StreamController
import 'package:http/http.dart' as http;
import 'package:blocs/skin.dart';

class SkinBloc {
  final StreamController<List<Skin>> _skinsController = StreamController<List<Skin>>.broadcast();

  Stream<List<Skin>> get allSkins => _skinsController.stream;

  fetchAllSkins() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/skins/'));
      if (response.statusCode == 200) {
        List<Skin> skins = (json.decode(response.body) as List)
            .map((data) => Skin.fromJson(data))
            .toList();
        _skinsController.sink.add(skins);
      } else {
        throw Exception('Failed to load skins with status code ${response.statusCode}');
      }
    } catch (e) {
      _skinsController.addError('HAHAHAHAHA: $e'); // Sending error to the stream
    }
  }

  void dispose() {
    _skinsController.close();
  }
}
