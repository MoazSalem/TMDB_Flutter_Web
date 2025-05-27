import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/features/shows/show_detail/data/repo/show_details_repo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'show_details_state.dart';

class ShowDetailsCubit extends Cubit<ShowDetailsState> {
  ShowDetailsCubit() : super(ShowDetailsInitial());

  getShow({required int id}) async {
    ShowDetailsRepo showDetailsRepo = GetIt.I.get<ShowDetailsRepo>();
    final show = await showDetailsRepo.getShow(id: id);
    final trailer = await showDetailsRepo.getTrailer(id: id);
    final cast = await showDetailsRepo.getCast(id: id);
    final suggestions = await showDetailsRepo.getSuggestions(id: id);
    final similar = await showDetailsRepo.getSuggestions(id: id, type: 1);
    final reviews = await showDetailsRepo.getReviews(id: id, pageNum: 1);
    final videoController = YoutubePlayerController();
    videoController.cueVideoById(videoId: trailer.key!);
    emit(
      ShowDetailsLoaded(
        show: show,
        trailer: trailer,
        videoController: videoController,
        cast: cast,
        suggestions: suggestions,
        similar: similar,
        reviews: reviews,
      ),
    );
  }
}
