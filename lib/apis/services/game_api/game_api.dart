import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fixiconn/apis/models/game_model.dart';
import 'package:fixiconn/apis/services/api_service.dart';
import 'package:fixiconn/apis/urls/connection_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameApi {
  ApiService apiService = ApiService(baseUrl: ConnectionUrls.baseUrl);
  GameApi(this.ref);
  final Ref ref;

  //get
  Future<GameModel> getAllRandomGame() async {
    try {
      final response = await apiService.get(
        endpoint: ConnectionUrls.getAllGames,
      );
      final body = jsonDecode(response.body);

      return GameModel.fromJson(body);
    } on TimeoutException catch (_) {
      return GameModel(
        success: false,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return GameModel(
        success: false,
        message: 'No Internet connection',
      );
    } catch (e) {
      final err = e as Map;
      final code = err['code'];
      final message = err['message'];
      final requestErr = err['error'];
      return GameModel(
        success: code ?? 'false',
        message: message ?? requestErr ?? 'Something went wrong $e',
      );
    }
  }

//get
  Future<GameModel> getRandom() async {
    try {
      final response = await apiService.get(
        endpoint: ConnectionUrls.getGame5,
      );
      final body = jsonDecode(response.body);

      return GameModel.fromJson(body);
    } on TimeoutException catch (_) {
      return GameModel(
        success: false,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return GameModel(
        success: false,
        message: 'No Internet connection',
      );
    } catch (e) {
      final err = e as Map;
      final code = err['code'];
      final message = err['message'];
      final requestErr = err['error'];
      return GameModel(
        success: code ?? 'false',
        message: message ?? requestErr ?? 'Something went wrong $e',
      );
    }
  }
}

final gameApiProvider = Provider<GameApi>((ref) => GameApi(ref));
