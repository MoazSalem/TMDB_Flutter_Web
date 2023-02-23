import 'package:flutter/material.dart';
import 'package:netflix_web/models/tv.dart';
import 'package:netflix_web/screens/tvShows/tv_page.dart';
import 'package:netflix_web/services/tv_service.dart';

late TvShow show;
bool loading = true;

// This page is opened when you press on a movie
class TvInfo extends StatefulWidget {
  final String id;

  const TvInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  getShow({required int id}) async {
    show = tvShowsList.isNotEmpty
        ? tvShowsList.firstWhere((movie) => movie.id == id)
        : await TVService().getShow(id: id);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int parsedId = int.parse(widget.id);
    getShow(id: parsedId);
    ThemeData theme = Theme.of(context);
    double currentWidth = MediaQuery.of(context).size.width;
    currentWidth > 800 ? currentWidth /= 2 : currentWidth *= 1.2;
    return Scaffold(
      backgroundColor: theme.canvasColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: tvShowsList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                mini: true,
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            )
          : Container(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://image.tmdb.org/t/p/original/${show.backdropPath ?? show.posterPath}"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: Text(
                    show.name,
                    style: TextStyle(
                      fontSize: currentWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: currentWidth * 0.035,
                          color: theme.textTheme.bodySmall!.color),
                      children: <TextSpan>[
                        const TextSpan(text: "Rating: "),
                        TextSpan(
                            text: show.voteAverage
                                .toStringAsFixed(1)
                                .replaceFirst(RegExp(r'\.?'), ''),
                            style: TextStyle(color: theme.primaryColor)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Overview:",
                    style: TextStyle(fontSize: currentWidth * 0.035, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    show.overview,
                    style: TextStyle(fontSize: currentWidth * 0.03, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
    );
  }
}
