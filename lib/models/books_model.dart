class BooksModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String pdfUrl;
  final String coverImageUrl;
  final String publishedDate;
  final String genre;
  final String categoryId;

  BooksModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.pdfUrl,
    required this.coverImageUrl,
    required this.publishedDate,
    required this.genre,
    required this.categoryId,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      publishedDate: json['publishedDate'] ?? '',
      genre: json['genre'] ?? '',
      categoryId: json['categoryId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'pdfUrl': pdfUrl,
      'coverImageUrl': coverImageUrl,
      'publishedDate': publishedDate,
      'genre': genre,
      'categoryId': categoryId,
    };
  }
}
