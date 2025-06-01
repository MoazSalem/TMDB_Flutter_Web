import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class ActorWidget extends StatelessWidget {
  ActorWidget({super.key, required this.member});
  final Cast member;
  final Color grey = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 50,
              child: ClipOval(
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl:
                      "${Constants.imagesBaseUrl}${Constants.profileSizes[1]}${member.profilePath}",
                  placeholder: (context, url) => const SizedBox(
                    height: 100,
                    width: 100,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person, color: Colors.white, size: 40),
                ),
              ),
            ),
            SizedBox(height: 0.5.h > 5 ? 5 : 0.5.h),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  "${member.name}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  "${member.character}",
                  style: TextStyle(fontSize: 10, color: grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
