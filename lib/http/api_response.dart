import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final bool success;
  final String message;
  final dynamic data;
  const ApiResponse(
      {required this.success, required this.message, required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [success, message, data];
}
