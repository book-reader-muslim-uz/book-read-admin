class BooksModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String pdfUrl;
  final String coverImageUrl;
  final DateTime publishedDate;
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

  // JSON dan modelga o'tkazish
  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      publishedDate:
          DateTime.parse(json['publishedDate'] ?? DateTime.now().toString()),
      genre: json['genre'] ?? '',
      categoryId: json['categoryId'] ?? '',
    );
  }

  // Modelni JSON formatiga o'tkazish
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'pdfUrl': pdfUrl,
      'coverImageUrl': coverImageUrl,
      'publishedDate': publishedDate.toIso8601String(),
      'genre': genre,
      'categoryId': categoryId,
    };
  }

}
