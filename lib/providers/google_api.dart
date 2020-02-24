import 'dart:convert';

import 'package:book_catalog_tool/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class GoogleApi {
  String URL = "https://www.googleapis.com/books/v1/volumes?q=isbn:";

  GoogleApi();

  Future<Book> fetchBookData(String isbn) async {
    return http.get(URL + isbn).then((http.Response response) {
      return _parseBookData(response.body);
    });
  }

  Book _parseBookData(String body) {
    final parsed = jsonDecode(body);
    return Book(
      title: parsed['items'][0]['volumeInfo']['title'],
      author: parsed['items'][0]['volumeInfo']['authors'][0],
      isbn: parsed['items'][0]['volumeInfo']['industryIdentifiers'][0]['type'] == 'ISBN_13' ? parsed['items'][0]['volumeInfo']['industryIdentifiers'][0]['identifier'] : parsed['items'][0]['volumeInfo']['industryIdentifiers'][1]['identifier'],
      description: parsed['items'][0]['volumeInfo']['description'],
      thumbnail: parsed['items'][0]['volumeInfo']['imageLinks']['smallThumbnail']
    );
  }
}