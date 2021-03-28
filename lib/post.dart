// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));


class Post {
  Post({
    this.title,
    this.image,
    this.rating,
    this.releaseYear,
    this.genre,
  });

  String title;
  String image;
  double rating;
  int releaseYear;
  List<String> genre;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    title: json["title"],
    image: json["image"],
    rating: json["rating"].toDouble(),
    releaseYear: json["releaseYear"],
    genre: List<String>.from(json["genre"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "rating": rating,
    "releaseYear": releaseYear,
    "genre": List<dynamic>.from(genre.map((x) => x)),
  };
}
