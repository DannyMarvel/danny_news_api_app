import 'dart:convert';

import '../model/newsmodel.dart';
import 'package:http/http.dart';

class News {
  //Here we save json data inside this
  List<ArticleModel> datatobesavedin = [];

  Future<void> getNews() async {
    var response = await get(
      Uri.parse(
          'http://newsapi.org/v2/top-headlines?country=us&apiKey=52489cf346804f2eb180b8e34528aa26'),
    );
    //so we convert the respone we getting to json
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
//The we procced and initialize our model class
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}

//fetching News by  categories
class CategoryNews {
  List<ArticleModel> datatobesavedin = [];

  Future<void> getNews(String category) async {
    var response = await get(
      Uri.parse(
          'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=52489cf346804f2eb180b8e34528aa26'),
    );
    //so we convert the respone we getting to json
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
//The we procced and initialize our model class
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}
