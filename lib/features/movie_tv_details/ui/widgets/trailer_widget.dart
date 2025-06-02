import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerWidget extends StatefulWidget {
  const TrailerWidget({super.key, required this.videoController});
  final YoutubePlayerController videoController;

  @override
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  bool videoPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: "Trailer"),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 92.w),
            child: Stack(
              children: [
                YoutubePlayer(
                  controller: widget.videoController,
                  aspectRatio: 16 / 9,
                ),
                PointerInterceptor(
                  child: InkWell(
                    onTap: () {
                      videoPressed
                          ? widget.videoController.pauseVideo()
                          : widget.videoController.playVideo();
                      videoPressed = !videoPressed;
                    },
                    child: const AspectRatio(aspectRatio: 16 / 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
