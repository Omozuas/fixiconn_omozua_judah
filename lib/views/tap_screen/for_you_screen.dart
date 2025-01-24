// ignore_for_file: deprecated_member_use

import 'package:fixiconn/db/dummydata.dart';
import 'package:fixiconn/views/tap_screen/widgets/first_custom_detail.dart';
import 'package:fixiconn/views/tap_screen/widgets/second_custom_detail.dart';
import 'package:fixiconn/views/tap_screen/widgets/video_player_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: dummyData.length,
      controller: PageController(initialPage: 0, viewportFraction: 1),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final v = dummyData[index];
        final isLiked = likedVideos.contains(v["id"]);
        return Stack(
          children: [
            VideoPlayerItem(videoUrl: v["videoUrl"]),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
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
    );
  }

  // Store liked video IDs
  Set<int> likedVideos = {};

  void toggleLike(int videoId) {
    setState(() {
      if (likedVideos.contains(videoId)) {
        likedVideos.remove(videoId);
        dummyData.firstWhere((video) => video["id"] == videoId)["likes"] -= 1;
      } else {
        likedVideos.add(videoId);
        dummyData.firstWhere((video) => video["id"] == videoId)["likes"] += 1;
      }
    });
  }
}
