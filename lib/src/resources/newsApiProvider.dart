import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import 'repository.dart';
import '../models/item.modal.dart';

final _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_baseUrl/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_baseUrl/item/$id.json');
    final item = json.decode(response.body);

    return ItemModel.fromJson(item);
  }
}
