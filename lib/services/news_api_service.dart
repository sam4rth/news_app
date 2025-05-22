import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsApiService {
  static const String _apiKey = 'b13f99d5f8194979b8ca9235390204f7'; // Replace with your key
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    final url = Uri.parse('$_baseUrl?country=$country&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromNewsApiJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}