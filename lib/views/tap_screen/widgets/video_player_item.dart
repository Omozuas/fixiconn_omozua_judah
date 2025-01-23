// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'package:fixiconn/constants/constants.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((onValue) {
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(6);
        setState(() {});
      });
    videoPlayerController.addListener(() {
      setState(() {}); // Update the UI whenever the controller's state changes
    });
    videoPlayerController.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: appBlack),
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              videoPlayerController.value.isPlaying
                  ? videoPlayerController.pause()
                  : videoPlayerController.play();
            });
          },
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              // Add a slider for seeking

              Positioned(
                bottom: -18,
                right: -20,
                // left: 0,
                width: size.width.w,
                child: Slider(
                  activeColor: white,
                  min: 0.0,
                  max:
                      videoPlayerController.value.duration.inSeconds.toDouble(),
                  value:
                      videoPlayerController.value.position.inSeconds.toDouble(),
                  onChanged: (value) {
                    videoPlayerController
                        .seekTo(Duration(seconds: value.toInt()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
