import 'package:flutter/material.dart';
import '../models/article.dart';

class BookmarksProvider with ChangeNotifier{
  final List<Article> _bookmarkedArticles = [];

  List<Article> get bookmarks => _bookmarkedArticles;

  void toggleBookmark(Article article){
    final isBookmarked = _bookmarkedArticles.contains(article);
    if(isBookmarked){
      _bookmarkedArticles.remove(article);
    }else{
      _bookmarkedArticles.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article){
    return _bookmarkedArticles.contains(article);
  }
}