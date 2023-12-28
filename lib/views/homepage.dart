import 'package:danny_news_app/helper/category_data.dart';
import 'package:danny_news_app/helper/newsdata.dart';
import 'package:danny_news_app/model/category_model.dart';
import 'package:danny_news_app/model/newsmodel.dart';
import 'package:danny_news_app/views/categorypage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Now we implement the loading Indicator
  bool _Loading = true;

  List<CategoryModel>? categories;
//Now we get our newslist  first
  List<ArticleModel> articles = <ArticleModel>[];
  // datatobesavedin.add(articleModel);

  Future<void> news() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    //If news() method  is succesfull then
    setState(() {
      _Loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    //we call news in initstate, whenever our app runs
    //The Method news runs
    news();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Danny ',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News App',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
//if  _Loading is true then circularPI
      body: _Loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 70,
                      child: ListView.builder(
                        itemCount: categories!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            categoryName: categories![index].categoryName,
                            imageUrl: categories![index].imageUrl,
                          );
                        },
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {super.key, required this.categoryName, required this.imageUrl});

  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryFragment(category: categoryName.toLowerCase()),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 170,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                //This container cast shadow on the iamge
                //To let the text to show
                alignment: Alignment.center,
                width: 170,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black26),
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              )
            ],
          )),
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
