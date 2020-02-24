import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'book.dart';

class BookDAO{
  BookDAO();

  final Future<Database> database = getDatabasesPath().then((String path){
    return openDatabase(
        join(path, 'book_catalog_tool.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE book(id INTEGER PRIMIARY KEY AUTO_INCREMENT, title TEXT, author TEXT, isbn STRING, thumbnail STRING, description STRING)",
          );
        },
        version: 1
      );
  });

  Future<void> insertBook(Book book) async {
    final Database db = await database;
    await db.insert('book', book.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Book> getBook(Book book) async {
    final Database db = await database;
    List<Map<String, dynamic>> row = await db.query('book', where: "isbn = ?", whereArgs: [book.isbn], limit: 1);
    return Book(
      id: row[0]['id'],
      title: row[0]['title'],
      author: row[0]['author'],
      isbn: row[0]['isbn'],
      thumbnail: row[0]['thumbnail'],
      description: row[0]['description']
    );
  }

  Future<void> deleteBook(Book book) async {
    final Database db = await database;
    await db.delete('book', where: 'isbn = ?', whereArgs: [book.isbn]);
  }

  Future<List<Book>> books() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('book');
    return List.generate(maps.length, (index) {
      return Book(id: maps[index]['id'],
        title: maps[index]['title'],
        author: maps[index]['author'],
        isbn: maps[index]['isbn'],
        thumbnail: maps[index]['thumbnail'],
        description: maps[index]['description'],
      );
    });
  }
}