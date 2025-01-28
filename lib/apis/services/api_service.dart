import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fixiconn/apis/respones/general_respons.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  Future<GeneralRespons?> put(
      {required String endpoint,
      Map<String, dynamic>? body,
      String? token}) async {
    try {
      var response = await http
          .put(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 40));

      return generalResponsFromJson(response.body);
    } on TimeoutException catch (_) {
      return GeneralRespons(
        success: false,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return GeneralRespons(
        success: false,
        message: 'No Internet connection',
      );
    } catch (e) {
      return GeneralRespons(
        success: false,
        message: 'Something went wrong $e',
      );
    }
  }

  Future<Response> get({required String endpoint, String? token}) async {
    log('$baseUrl$endpoint');
    var response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 40));
    return response;
  }

  Future<GeneralRespons?> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      String? token}) async {
    log('$token');
    try {
      var response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 40));
      log(response.body);
      return generalResponsFromJson(response.body);
    } on TimeoutException catch (_) {
      return GeneralRespons(
        success: false,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return GeneralRespons(
        success: false,
        message: 'No Internet connection',
      );
    } catch (e) {
      final err = e as Map;

      final message = err['message'];
      final requestErr = err['error'];
      return GeneralRespons(
        success: false,
        message: message ?? requestErr ?? 'Something went wrong $e',
      );
    }
  }
}
