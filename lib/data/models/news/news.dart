import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: 'id', defaultValue: -1)
  final int id;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  @JsonKey(name: 'news_description', defaultValue: '')
  final String newsDescription;
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;

  const News({
    required this.id,
    required this.title,
    required this.image,
    required this.newsDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.image == image &&
        other.newsDescription == newsDescription &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        newsDescription.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class NewsList {
  final List<News> news;

  const NewsList({required this.news});

  factory NewsList.fromJson(List<dynamic> json) {
    return NewsList(
      news: json.map((e) => News.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  bool operator ==(covariant NewsList other) {
    if (identical(this, other)) return true;

    return listEquals(other.news, news);
  }

  @override
  int get hashCode => news.hashCode;
}
