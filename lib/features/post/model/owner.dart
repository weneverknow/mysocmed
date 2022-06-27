import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String picture;

  const Owner(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.picture});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, picture];
}
