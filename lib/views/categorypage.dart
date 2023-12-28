import 'package:flutter/material.dart';

import 'package:danny_news_app/helper/newsdata.dart';

import 'package:danny_news_app/model/newsmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryFragment extends StatefulWidget {
  CategoryFragment({super.key, required this.category});
  final String category;

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  bool _loading = true;

//Now we get our newslist  first
  List<ArticleModel> articles = <ArticleModel>[];
  // datatobesavedin.add(articleModel);

  Future<void> gorynews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gorynews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                widget.category.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Text(
            //   'News App',
            //   style: TextStyle(color: Colors.blue),
            // ),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  //makes the widget to scroll
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NewsTemplate(
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                        urlToImage: articles[index].urlToImage);
                  },
                ),
              ),
            ),
    );
  }
}

//Now we create a Template for News
class NewsTemplate extends StatelessWidget {
  const NewsTemplate({
    super.key,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: urlToImage,
              width: 500,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
