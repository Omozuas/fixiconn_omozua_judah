import 'dart:async';
import 'dart:developer';

import 'package:fixiconn/apis/models/video_model.dart';
import 'package:fixiconn/apis/services/video_api/video_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetVideosProvider extends AutoDisposeAsyncNotifier<VideoModel?> {
  @override
  Future<VideoModel?> build() async {
    getVideos(limit: 10);
    return null;
  }

  Future<void> getVideos({required int limit}) async {
    final video = ref.read(videoApiProvider);

    try {
      state = const AsyncLoading();
      final response = await video.getViseos(limit: limit);
      log('$response');
      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final getVideosProvider =
    AutoDisposeAsyncNotifierProvider<GetVideosProvider, VideoModel?>(
        GetVideosProvider.new);
