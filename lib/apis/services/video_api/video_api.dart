import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fixiconn/apis/models/video_model.dart';
import 'package:fixiconn/apis/respones/general_respons.dart';
import 'package:fixiconn/apis/services/api_service.dart';
import 'package:fixiconn/apis/urls/connection_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoApi {
  ApiService apiService = ApiService(baseUrl: ConnectionUrls.baseUrl);
  VideoApi(this.ref);
  final Ref ref;

//get
  Future<VideoModel> getViseos({required int limit}) async {
    final token = await getAccessToken();
    log(' $limit');
    try {
      final response = await apiService.get(
        endpoint: '${ConnectionUrls.getVideos}?page=1&limit=$limit',
        token: token,
      );
      final body = jsonDecode(response.body);
      log('$body 2');
      return VideoModel.fromJson(body);
    } on TimeoutException catch (_) {
      return VideoModel(
        success: false,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return VideoModel(
        success: false,
        message: 'No Internet connection',
      );
    } catch (e) {
      final err = e as Map;
      final code = err['code'];
      final message = err['message'];
      final requestErr = err['error'];
      return VideoModel(
        success: code ?? 'false',
        message: message ?? requestErr ?? 'Something went wrong $e',
      );
    }
  }

  Future<GeneralRespons> likeVideo({required String productId}) async {
    final token = await getAccessToken();
    try {
      final response = await apiService.put(
        endpoint: ConnectionUrls.likeVideo,
        token: token,
        body: {"productId": productId},
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}

final videoApiProvider = Provider<VideoApi>((ref) => VideoApi(ref));
