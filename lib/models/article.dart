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

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json['title'],
    summary: json['summary'],
    category: json['category'],
    isLong: json['isLong'],
    url: json['url'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'summary': summary,
    'category': category,
    'isLong': isLong,
    'url': url,
    'imageUrl': imageUrl,
  };
}
