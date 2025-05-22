import 'package:news_app/widgets/article_w.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bookmarks_provider.dart';

class BookmarksScreen extends StatelessWidget {
  static const routeName = '/bookmarks';

  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarks = Provider.of<BookmarksProvider>(context).bookmarks;

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: bookmarks.isEmpty
          ? const Center(child: Text('No bookmarks yet.'))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return ArticleW(
                  article: bookmarks[index],
                  onTap: () {},
                  onBookmarkToggle: () {
                    Provider.of<BookmarksProvider>(context, listen: false)
                        .toggleBookmark(bookmarks[index]);
                  },
                );
              },
            ),
    );
  }
}
