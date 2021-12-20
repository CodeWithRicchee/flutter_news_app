import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articals = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    getCategoryNews();
    super.initState();
  }

  getCategoryNews() async {
    CateogoryNewsClass newsClass = CateogoryNewsClass();
    await newsClass.getCategoryNews(widget.category);
    articals = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.category,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'News',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Container(
              child: Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.save),
            ),
          )),
        ],
      ),
      body: _loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // Blogs
                    Container(
                      height: MediaQuery.of(context).size.height - 70,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: articals.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageurl: articals[index].urlToImage,
                            title: articals[index].title,
                            desc: articals[index].description,
                            url: articals[index].url,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile(
      {Key? key,
      required this.imageurl,
      required this.title,
      required this.desc,
      required this.url})
      : super(key: key);
  final String? imageurl, title, desc, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(-10, 10),
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.only(
            top: 1,
            bottom: 20,
          ),
          margin: EdgeInsets.only(bottom: 18),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(imageurl!)),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  desc!,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
