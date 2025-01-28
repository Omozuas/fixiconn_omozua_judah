import 'dart:async';

import 'package:fixiconn/apis/models/game_model.dart';
import 'package:fixiconn/apis/services/game_api/game_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetRandomGame extends AutoDisposeAsyncNotifier<GameModel?> {
  @override
  Future<GameModel?> build() async {
    getRandomGame();
    return null;
  }

  Future<void> getRandomGame() async {
    final video = ref.read(gameApiProvider);

    try {
      state = const AsyncLoading();
      final response = await video.getRandom();

      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final getRandomGame =
    AutoDisposeAsyncNotifierProvider<GetRandomGame, GameModel?>(
        GetRandomGame.new);
