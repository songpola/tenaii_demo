class News {
  News({required this.data, required this.success});

  final List<NewsData> data;
  final bool success;

  factory News.fromJson(Map<String, dynamic> json) => News(
        data:
            List<NewsData>.from(json["data"].map((x) => NewsData.fromJson(x))),
        success: json["success"],
      );
}

class NewsData {
  NewsData({
    required this.url,
    required this.imageUrl,
  });

  final String url;
  final String imageUrl;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        url: json["url"],
        imageUrl: json["imageUrl"],
      );
}
