import 'dart:async';
import 'dart:developer';

import 'package:fixiconn/apis/models/game_model.dart';
import 'package:fixiconn/apis/services/game_api/game_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllRandomGame extends AutoDisposeAsyncNotifier<GameModel?> {
  @override
  Future<GameModel?> build() async {
    getAllRandomGame();
    return null;
  }

  Future<void> getAllRandomGame() async {
    final video = ref.read(gameApiProvider);

    try {
      state = const AsyncLoading();
      final response = await video.getAllRandomGame();
      log('$response');
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final getAllRandomGame =
    AutoDisposeAsyncNotifierProvider<GetAllRandomGame, GameModel?>(
        GetAllRandomGame.new);
