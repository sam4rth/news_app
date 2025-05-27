import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:provider/provider.dart';
import '../providers/bookmarks_provider.dart';
import '../screens/article_webview_screen.dart';

class ArticleW extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkToggle;

  const ArticleW({
    super.key,
    required this.article,
    this.onTap,
    this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ArticleWebViewScreen(
        url: article.url ?? "https://acmbphc.in/",
        title: article.title,
      ),
    ),
  );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.imageUrl ?? 'https://acmbphc.in/bits-acm-logo.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                article.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                article.summary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(article.category),
                    backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.blueAccent),
                  ),
                  IconButton(
                    icon: Icon(
                      Provider.of<BookmarksProvider>(context).isBookmarked(article)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      Provider.of<BookmarksProvider>(context, listen: false)
                          .toggleBookmark(article);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}