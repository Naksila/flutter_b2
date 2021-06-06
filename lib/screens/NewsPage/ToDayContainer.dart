import 'package:flutter/material.dart';
import 'package:flutter_b/screens/NewsPage/ArticleScreen.dart';
import 'package:flutter_b/model/Data.dart';


class ToDayContainer extends StatefulWidget {
  final Article article;

  const ToDayContainer({Key key, this.article}) : super(key: key);
  @override
  _ToDayContainerState createState() => _ToDayContainerState();
}

class _ToDayContainerState extends State<ToDayContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ArticleScreen(
                    article: widget.article,
                  )));
        },
        child: Container(
          margin: const EdgeInsets.only(right: 15),
          child: Stack(
            children: [
              Container(
                height: 250,
                width: 370,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(widget.article.image),
                    )),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: Colors.black54,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.article.title.length > 30
                            ? widget.article.title.substring(0, 20) + '...'
                            : widget.article.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
