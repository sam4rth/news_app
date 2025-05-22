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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              article.imageUrl ?? 'https://acmbphc.in/bits-acm-logo.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
            Text(article.title,
            style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 8,),
            Text(
              article.summary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(article.category,
                style: const TextStyle(color: Colors.blueGrey),
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
                )            
                ],
            )
          ],
        ),
        ),
      ),
    );
  }
}