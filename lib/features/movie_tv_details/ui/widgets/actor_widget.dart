import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/networking/constants.dart';

import 'avatar_image_widget.dart';

class ActorWidget extends StatelessWidget {
  ActorWidget({super.key, required this.member});
  final Cast member;
  final Color grey = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey.shade700,
              radius: 70,
              child: ClipOval(
                child: AvatarImageWidget(item: member, type: 'cast'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              "${member.name}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp > 24 ? 24 : 16.sp,
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              "${member.character}",
              style: TextStyle(fontSize: 18, color: grey),
            ),
          ],
        ),
      ),
    );
  }
}
