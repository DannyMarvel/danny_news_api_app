class ArticleModel {
  //Note the spelling must match the api, else no data
  String title;
  String description;
  String url;
  String urlToImage;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });
}
