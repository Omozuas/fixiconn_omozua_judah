// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:fixiconn/apis/river_pod/auth/auth_provider.dart';
import 'package:fixiconn/apis/river_pod/get_videos/get_videos.dart';
import 'package:fixiconn/common/app_style.dart';
import 'package:fixiconn/common/reuseable_text.dart';
import 'package:fixiconn/common/snackbar/custom_snack_bar.dart';
import 'package:fixiconn/constants/constants.dart';
import 'package:fixiconn/db/dummydata.dart';
import 'package:fixiconn/views/tap_screen/widgets/first_custom_detail.dart';
import 'package:fixiconn/views/tap_screen/widgets/second_custom_detail.dart';
import 'package:fixiconn/views/tap_screen/widgets/video_player_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ForYouScreen extends ConsumerStatefulWidget {
  const ForYouScreen({super.key});

  @override
  ConsumerState<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends ConsumerState<ForYouScreen> {
  late PageController _pageController;
  bool isLoading = false; // Prevent concurrent loading
  int page = 10;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1)
      ..addListener(() {
        if (_pageController.position.pixels ==
                _pageController.position.maxScrollExtent &&
            !isLoading) {
          Future.microtask(() => _loadMoreVideos());
        }
      });
    Future.microtask(() => _loadInitialData());
  }

  void _loadInitialData() async {
    final preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('userID') ?? '';
    setState(() {
      userId = id;
    });
    try {
      await ref.read(getVideosProvider.notifier).getVideos(limit: page);
      final info = ref.read(getVideosProvider).value;
      log('${info?.message ?? ''} messs');
      if (info == null) return;
      if (info.success == true) {
      } else {
        if (info.message == 'No Internet connection') {
          showError(info.message ?? '');
        }
      }
    } catch (e) {
      log('Error loading initial data: $e');
    }
  }

  void _loadMoreVideos() async {
    final preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('userID') ?? '';
    setState(() {
      userId = id;
    });
    setState(() {
      isLoading = true;
    });

    try {
      page += 10;
      await ref.read(getVideosProvider.notifier).getVideos(limit: page);
      final info = ref.read(getVideosProvider).value;
      if (info == null) return;
      if (info.success == true) {
      } else {
        if (info.message == 'No Internet connection') {
          showError(info.message ?? '');
        }
      }
    } catch (e) {
      log('Error loading more videos: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void likeVideo({required String videoId}) async {
    final preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('userID') ?? '';
    setState(() {
      userId = id;
    });

    try {
      setState(() {
        toggleLike(videoId);
      });
      await ref.read(setupProfileProvider.notifier).likeVideo(videoId: videoId);
      final res = ref.read(setupProfileProvider).likeVideo.value;
      if (res == null) return;
      Future.microtask(() => _loadMoreVideos());
    } catch (e) {
      log(e.toString());

      setState(() {
        toggleLike(videoId);
      });
      showError(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(getVideosProvider);
    ref.watch(setupProfileProvider).likeVideo.isLoading;
    return RefreshIndicator(
      onRefresh: () async {
        Future.microtask(() => _loadInitialData());
      },
      child: videos.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        data: (data) {
          final videoItem = data?.data ?? [];
          return PageView.builder(
            itemCount: videoItem.length,
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final v = videoItem[index];
              final isLiked = v.isLikes?.contains(userId) ?? false;
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: v.videoUrl ?? ''),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FirstCustomDetail(
                              username: v.username ?? '',
                              about: v.about ?? '',
                            ),
                            SecondCustomDetail(
                              profileImg: v.profileImage ?? '',
                              likes: v.likes?.toDouble() ?? 0,
                              comments: v.comments?.toDouble() ?? 0,
                              bookmark: v.bookmark?.toDouble() ?? 0,
                              shares: v.shares?.toDouble() ?? 0,
                              isLiked: isLiked,
                              onTap: () {
                                likeVideo(videoId: v.id ?? '');
                              },
                            )
                          ],
                        ),
                        if (isLoading == true)
                          ReuseableText(
                              text: 'loading...',
                              style: appStyle(12, white, FontWeight.w700))
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
        error: (e, s) {
          return Center(
              child: ReuseableText(
                  text: 'Refresh To Reload $e',
                  style: appStyle(12, white, FontWeight.w600)));
        },
        loading: () => Shimmer.fromColors(
          baseColor: white,
          highlightColor: skyBlue.withOpacity(0.1),
          child: PageView.builder(
            itemCount: dummyData.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final v = dummyData[index];
              final isLiked = likedVideos.contains(v["id"]);
              return Stack(
                children: [
                  // VideoPlayerItem(videoUrl: v["videoUrl"]),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FirstCustomDetail(
                              username: v["username"],
                              about: v["about"],
                            ),
                            SecondCustomDetail(
                                profileImg: v["profileImage"],
                                likes: v["likes"].toDouble(),
                                comments: v["comments"].toDouble(),
                                bookmark: v["bookmarks"].toDouble(),
                                shares: v["shares"].toDouble(),
                                isLiked: isLiked,
                                onTap: () => toggleLike(v["id"]))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Store liked video IDs
  Set<String> likedVideos = {};

  void toggleLike(String videoId) {
    // Find the video in the current list
    final videos = ref.read(getVideosProvider).value?.data;
    if (videos == null) return;

    final video = videos.firstWhere(
      (v) => v.id == videoId,
    );

    setState(() {
      if (video.isLikes?.contains(userId) ?? false) {
        // Unlike: Remove userId and decrement likes count
        video.isLikes?.remove(userId);
        video.likes = (video.likes ?? 0) - 1;
      } else {
        // Like: Add userId and increment likes count
        video.isLikes?.add(userId);
        video.likes = (video.likes ?? 0) + 1;
      }
    });
  }
}
