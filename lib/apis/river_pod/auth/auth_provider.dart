import 'dart:developer';

import 'package:fixiconn/apis/respones/general_respons.dart';
import 'package:fixiconn/apis/services/auth_api/auth_api.dart';
import 'package:fixiconn/apis/services/video_api/video_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetupProfileProvider
    extends AutoDisposeNotifier<SetupProfileProviderStates> {
  @override
  SetupProfileProviderStates build() {
    return const SetupProfileProviderStates(
      signup: AsyncData(null),
      login: AsyncData(null),
      likeVideo: AsyncData(null),
    );
  }

  Future<void> signUp(
      {required String userName, required String password}) async {
    final auth = ref.read(authApiProvider);
    try {
      state = state.copyWith(signup: const AsyncLoading());
      final response =
          await auth.createUser(userName: userName, password: password);
      state = state.copyWith(signup: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(signup: AsyncError(e.toString(), StackTrace.current));
    }
  }

  Future<void> login(
      {required String userName, required String password}) async {
    final auth = ref.read(authApiProvider);
    try {
      state = state.copyWith(login: const AsyncLoading());
      final response =
          await auth.loginData(userName: userName, password: password);
      state = state.copyWith(login: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(login: AsyncError(e.toString(), StackTrace.current));
    }
  }

  Future<void> likeVideo({required String videoId}) async {
    final auth = ref.read(videoApiProvider);
    try {
      state = state.copyWith(likeVideo: const AsyncLoading());
      final response = await auth.likeVideo(productId: videoId);
      log('${response.data} cc');
      state = state.copyWith(likeVideo: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          likeVideo: AsyncError(e.toString(), StackTrace.current));
    }
  }
}

final setupProfileProvider = AutoDisposeNotifierProvider<SetupProfileProvider,
    SetupProfileProviderStates>(SetupProfileProvider.new);

class SetupProfileProviderStates {
  final AsyncValue<GeneralRespons?> signup;
  final AsyncValue<GeneralRespons?> login;
  final AsyncValue<GeneralRespons?> likeVideo;

  const SetupProfileProviderStates({
    required this.signup,
    required this.login,
    required this.likeVideo,
  });
  SetupProfileProviderStates copyWith({
    AsyncValue<GeneralRespons?>? signup,
    AsyncValue<GeneralRespons?>? login,
    AsyncValue<GeneralRespons?>? likeVideo,
  }) {
    return SetupProfileProviderStates(
        signup: signup ?? this.signup,
        login: login ?? this.login,
        likeVideo: likeVideo ?? this.likeVideo);
  }
}
