import 'package:http/http.dart';
import 'package:my_socmed/config/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_response.dart';

class RequestService {
  static Future<ApiResponse> get({required String url}) async {
    var headers = {"app-id": appid};
    var response = await http.get(Uri.parse(url), headers: headers);
    //return response;
    var data = jsonDecode(response.body);
    //print("[RequestService] $data");
    return ApiResponse(
        success: response.statusCode == 200,
        message: response.statusCode == 200
            ? "Load successfully"
            : "Something went wrong",
        data: data);
  }

  static Future<ApiResponse> put(
      {required String url, required Map<String, dynamic> body}) async {
    var headers = {"app-id": appid};
    var response = await http.put(Uri.parse(url), body: body, headers: headers);
    var data = jsonDecode(response.body);
    return ApiResponse(
        success: response.statusCode == 200,
        message: response.statusCode == 200
            ? "Updated successfully"
            : "Something went wrong",
        data: data);
  }
}
