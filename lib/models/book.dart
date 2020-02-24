class Book {
  final int id;
  final String title;
  final String author;
  final String isbn;
  final String thumbnail;
  final String description;

  Book({this.id, this.title, this.author, this.isbn, this.thumbnail, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "title": title,
      "author": author,
      "isbn": isbn,
      "thumbnail": thumbnail,
      "description": description
    };
  }
}