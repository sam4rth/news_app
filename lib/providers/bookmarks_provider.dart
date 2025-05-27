import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksProvider with ChangeNotifier {
  final List<Article> _bookmarkedArticles = [];

  List<Article> get bookmarks => _bookmarkedArticles;

  BookmarksProvider() {
    _loadBookmarks(); // Load on init
  }

  void toggleBookmark(Article article) {
    final isBookmarked = _bookmarkedArticles.any((a) => a.title == article.title);
    if (isBookmarked) {
      _bookmarkedArticles.removeWhere((a) => a.title == article.title);
    } else {
      _bookmarkedArticles.add(article);
    }
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarkedArticles.any((a) => a.title == article.title);
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = _bookmarkedArticles.map((a) => json.encode(a.toJson())).toList();
    await prefs.setStringList('bookmarks', encodedList);
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('bookmarks') ?? [];
    _bookmarkedArticles.clear();
    _bookmarkedArticles.addAll(
      encodedList.map((e) => Article.fromJson(json.decode(e))).toList(),
    );
    notifyListeners();
  }
}
