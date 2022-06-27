import 'package:equatable/equatable.dart';

import '../../user_location/model/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String picture;
  final String title;
  final String? gender;
  final String? email;
  final String? dateOfBirth;
  final String? phone;
  final Location? location;
  final DateTime? registerDate;
  final DateTime? updatedDate;

  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.picture,
      required this.title,
      this.gender,
      this.email,
      this.dateOfBirth,
      this.phone,
      this.location,
      this.registerDate,
      this.updatedDate});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, picture, title];
}
