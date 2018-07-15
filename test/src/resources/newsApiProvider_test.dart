import 'package:news/src/resources/newsApiProvider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

main() {
  test('fetchTopIds should return a list of top IDs', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient(
      (Request request) async => Response(
            json.encode([1, 2, 3, 4]),
            200,
          ),
    );

    final response = await newsApi.fetchTopIds();

    expect(response, [1, 2, 3, 4]);
  });

  test('fetchItem should return an item', () async {
    final newsApi = NewsApiProvider();
    final response = {"id": 123};

    newsApi.client = MockClient(
      (Request request) async => Response(
            json.encode(response),
            200,
          ),
    );

    final item = await newsApi.fetchItem(123);

    expect(item.id, response['id']);
  });
}
