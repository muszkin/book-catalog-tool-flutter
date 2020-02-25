import 'dart:convert';

import 'package:book_catalog_tool/screens/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'models/book.dart';
import 'providers/google_api.dart';
import 'models/bookDAO.dart' as bookDAO;


void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Catalog Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Book Catalog Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> books = List<Book>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _MyHomePageState() {
    bookDAO.BookDAO().books().then((List<Book> books){
      for (Book book in books) {
        this.books.add(book);
      }
    });
  }

  Future _scanNewBookISBN() async {
    String barcode = await scanner.scan();
    Book book = await GoogleApi().fetchBookData(barcode);
    setState(() {
      bookDAO.BookDAO().insertBook(book);
      books.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: books.length,
          itemBuilder: (context, index) {
              return new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookDetailsScreen(book: books[index],)),
                  );
                },
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(16.0)),
                      new Text(books[index].toMap()['title'],style: _biggerFont)
                    ],
                  ),),
                );
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanNewBookISBN,
        tooltip: 'Scan ISBN',
        child: Icon(Icons.add),
      ),
    );
  }
}
