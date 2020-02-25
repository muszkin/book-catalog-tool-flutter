import 'package:book_catalog_tool/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class BookDetailsScreen extends StatelessWidget {

  BookDetailsScreen({@required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return BookDetailsWidget(book: book);
  }
}

class BookDetailsWidget extends StatefulWidget {
  BookDetailsWidget({Key key, @required this.book}) : super(key: key);

  final Book book;

  @override
  _BookDetailsWidgetState createState() => _BookDetailsWidgetState();
}

class _BookDetailsWidgetState extends State<BookDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        leading:new GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: new Icon(Icons.arrow_back),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(widget.book.thumbnail)
              ],
            ),
          ),
          Expanded(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: new Text("Title: " + widget.book.title),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(child: new Text("Authors: " + widget.book.title))
                    ],
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: new Text("Description: " +  widget.book.description)
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}