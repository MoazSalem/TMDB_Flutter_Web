import 'package:flutter/material.dart';
import 'package:netflix_web/models/movies.dart';
import 'package:netflix_web/screens/movie_info.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// This is the widget that is shown per movie in the main page.
Widget movieWidget({required Movie movie, required BuildContext context}) {
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MovieInfo(movie: movie))),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          child:
              Image.network(fit: BoxFit.fill, "https://image.tmdb.org/t/p/w500${movie.posterPath}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black87,
            child: CircularPercentIndicator(
              animationDuration: 3000,
              curve: Curves.bounceOut,
              radius: 24.0,
              lineWidth: 3.0,
              percent: (movie.voteAverage / 10),
              animation: true,
              center: Text(
                (movie.voteAverage * 10).toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              progressColor: progressColor(rating: (movie.voteAverage * 10)),
            ),
          ),
        )
      ],
    ),
  );
}

Color progressColor({required double rating}) {
  return rating <= 25
      ? Colors.red
      : rating > 25 && rating <= 50
          ? Colors.red.shade300
          : rating > 50 && rating < 70
              ? Colors.yellow
              : Colors.deepPurpleAccent;
}
