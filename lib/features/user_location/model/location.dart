import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final String street;
  final String city;
  final String state;
  final String country;
  final String timezone;

  const Location(
      {required this.street,
      required this.city,
      required this.state,
      required this.country,
      required this.timezone});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [street, city, state, country, timezone];
}
