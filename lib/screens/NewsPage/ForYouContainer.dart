import 'package:flutter/material.dart';
import 'package:flutter_b/screens/NewsPage/ArticleScreen.dart';
import 'package:flutter_b/model/Data.dart';

class ForYouContainer extends StatefulWidget {
  final Article article;

  const ForYouContainer({Key key, this.article}) : super(key: key);
  @override
  _ForYouContainerState createState() => _ForYouContainerState();
}

class _ForYouContainerState extends State<ForYouContainer> {
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
        height: 130,
        width: MediaQuery.of(context).size.width - 50,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(width: 0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(3, 3),
              )
            ]),
        child: Row(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.article.image),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.article.category,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.article.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    /*
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleScreen(
                  article: widget.article,
                )));
      },
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width - 35,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xfff3f3f3),
            boxShadow: [
              BoxShadow(
                color: Color(0xff6D6968),
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(3, 3),
              )
            ]),
        child: Row(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: AssetImage(widget.article.image), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.article.category,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.article.title,
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

     */
  }
}
