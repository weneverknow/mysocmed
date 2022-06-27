// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      image: json['image'] as String,
      likes: json['likes'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      text: json['text'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'likes': instance.likes,
      'tags': instance.tags,
      'text': instance.text,
      'publishDate': instance.publishDate.toIso8601String(),
      'owner': instance.owner,
      'isLiked': instance.isLiked,
    };
