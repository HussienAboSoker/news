class NewsModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String url;

  NewsModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      image: json['urlToImage'] as String?,
      title: json['title'] as String? ?? 'No Title',
      subTitle: json['description'] as String?,
      url: json['url'] as String? ?? '',
    );
  }
}
