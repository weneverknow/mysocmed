import 'package:equatable/equatable.dart';
import 'package:my_socmed/features/post/model/owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String id;
  final String image;
  final int likes;
  final List<String> tags;
  final String text;
  final DateTime publishDate;
  final Owner owner;
  final bool isLiked;

  const Post(
      {required this.id,
      required this.image,
      required this.likes,
      required this.tags,
      required this.text,
      required this.publishDate,
      required this.owner,
      this.isLiked = false});

  Post copyWith({bool? isLiked}) {
    return Post(
        id: id,
        image: image,
        likes: likes,
        tags: tags,
        text: text,
        publishDate: publishDate,
        owner: owner,
        isLiked: isLiked ?? this.isLiked);
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, image, likes, tags, text, publishDate, owner, isLiked];
}
