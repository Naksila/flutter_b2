import 'package:flutter_b/model/Data.dart';
import 'package:flutter_b/screens/NewsPage/ForYouContainer.dart';
import 'package:flutter_b/screens/NewsPage/ToDayContainer.dart';
import 'package:flutter_b/header.dart';
import 'package:flutter/material.dart';


class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Widget buildForYouContainers() {
    List<Widget> forYouContainers = [];
    for (Article article in forYou) {
      forYouContainers.add(ForYouContainer(
        article: article,
      ));
    }

    return Column(
      children: forYouContainers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff468189),
      //Color(0xffc5f2ed),
      body: Column(
        children: [
          Header(),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xffFFFFFe)),
              child: Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Top Stories',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.only(left: 10),
                      child: ListView.builder(
                          itemCount: trendingNews.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            Article article = trendingNews[index];
                            return ToDayContainer(
                              article: article,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildForYouContainers(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
