import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({super.key, required this.item, required this.pageType});
  final String pageType;
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ListView.builder(
          itemCount: item.genres!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => context.go(
              "/${pageType == "movies" ? "movies" : "tv"}/${"${item.genres![index].name}".toLowerCase()}/1",
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 12,
              child: Text(
                item.genres![index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
