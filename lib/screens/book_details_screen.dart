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
      body:Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child:
            Row(
              children: [
                Expanded(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(widget.book.thumbnail)
                      ],
                    )
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Title: " + widget.book.title),
                      Divider(height: 32,),
                      Text("Authors: " + widget.book.title)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description: ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Divider(height: 32,),
                      Text(widget.book.description,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}