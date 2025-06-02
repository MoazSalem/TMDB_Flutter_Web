import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.isSearch = true,
    this.showSearchIcon = true,
    this.isMovie = true,
  });
  final bool isSearch;
  final bool showSearchIcon;
  final bool isMovie;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.black,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildLogo(context),
              _buildNavLink(context, "Movies", '/movies'),
              _buildNavLink(context, "Tv Shows", '/tv'),
              if (showSearchIcon)
                Padding(
                  padding: EdgeInsets.only(left: 60.w < 400 ? 0 : 60.w),
                  child: _buildSearchIcon(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => context.go('/'),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xff8fcea2), Color(0xff2dbbcf)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Row(
          children: [
            const Text(
              "TMDB",
              style: TextStyle(
                fontSize: 26,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () => context.go(route),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => isSearch
          ? context.go('/${isMovie ? "movies" : "tv"}/search')
          : context.pop(),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: Icon(
          isSearch ? Icons.search : Icons.close,
          size: 24,
          color: const Color(0xff3fbfc7),
        ),
      ),
    );
  }
}
