class Article {
  final String title;
  final String summary;
  final String category;
  final bool isLong;
  final String? url;
  final String? imageUrl;

  Article({
    required this.title,
    required this.summary,
    required this.category,
    required this.isLong,
    this.url,
    this.imageUrl,
  });
//TODO
 factory Article.fromNewsApiJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      summary: json['description'] ?? '',
      category: json['source']?['name'] ?? 'General',
      isLong: false,
      url: json['url'],
      imageUrl: json['urlToImage'],
    );
  }
}
