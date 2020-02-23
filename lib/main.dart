import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;


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
  final barcodes = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future _scanNewBookISBN() async {
    String barcode = await scanner.scan();
    setState(() => this.barcodes.add(barcode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: new GestureDetector(
          onTap: () {
            setState(() {
              http.post("http://10.0.2.2:9999/post.php",body: jsonEncode(barcodes)).then((http.Response response) {
                if (response.statusCode == 200) {
                  setState(() {
                    this.barcodes.clear();
                  });
                  return
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text("Information"),
                          content: new Text("Data sended."),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                    );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text("Information"),
                          content: new Text("Error."),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      }
                  );
                }
              });
            });
          },
          child: Icon(
            Icons.send,
          ),
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: barcodes.length,
          itemBuilder: (context, index) {
              return new GestureDetector(
                onTap: () {
                  setState(() {
                    this.barcodes.removeAt(index);
                  });
                },
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(16.0)),
                      new Text(barcodes[index],style: _biggerFont)
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
