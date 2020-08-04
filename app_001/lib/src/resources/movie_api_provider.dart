import 'dart:async';
import 'package:app_001/src/models/itemd_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '4ea9370eb5108287a863510d13e3af89';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}