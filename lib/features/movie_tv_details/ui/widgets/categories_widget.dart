import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.item, required this.index});
  final dynamic item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => context.go(
          "/${item.title != null ? "movies" : "tv"}/${"${item.genres![index].name}".toLowerCase()}/1",
        ),
        child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: const Color(0xff039ac3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 16,
                child: Center(
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
        ),
      ),
    );
  }
}
