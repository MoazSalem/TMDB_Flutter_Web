import 'package:flutter/material.dart';
import 'package:tmdb_web/core/shared_widgets/horizontal_poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

class SuggestionsListWidget extends StatelessWidget {
  const SuggestionsListWidget({
    super.key,
    required this.suggestions,
    required this.pageType,
    required this.title,
  });
  final dynamic suggestions;
  final String pageType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title),
        HorizontalPosterListWidget(list: suggestions, pageType: pageType),
      ],
    );
  }
}
