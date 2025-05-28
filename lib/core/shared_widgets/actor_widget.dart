import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/models/cast.dart';

class ActorWidget extends StatelessWidget {
  ActorWidget({super.key, required this.member});
  final Cast member;
  final Color grey = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w > 5 ? 5 : 2.w),
      child: SizedBox(
        width: 25.w > 120 ? 120 : 25.w,
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xff0d9bc6),
                radius: 50,
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://image.tmdb.org/t/p/w200${member.profilePath}",
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
                    "${member.character?.split("/")[0]}",
                    style: TextStyle(fontSize: 10, color: grey),
                  ),
                ),
              ),
              member.character!.split("/").length > 1
                  ? Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              "${member.character?.split("/")[1]}",
                              style: TextStyle(fontSize: 10, color: grey),
                            ),
                          ),
                        ),
                        member.character!.split("/").length > 2
                            ? SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    "${member.character?.split("/")[2]}",
                                    style: TextStyle(fontSize: 10, color: grey),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
