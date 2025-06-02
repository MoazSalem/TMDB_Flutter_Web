import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/actor_widget.dart';

class CastListWidget extends StatelessWidget {
  const CastListWidget({super.key, required this.cast});
  final List<Cast> cast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: "Cast"),
        SizedBox(
          height: 55.w > 280 ? 280 : 55.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (BuildContext context, int index) =>
                ActorWidget(member: cast[index]),
          ),
        ),
      ],
    );
  }
}
