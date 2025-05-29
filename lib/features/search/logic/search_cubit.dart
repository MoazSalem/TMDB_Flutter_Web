import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/networking/error_handling.dart';
import 'package:tmdb_web/features/search/data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search({required String query, required int type}) async {
    emit(SearchLoading());
    try {
      final result = await GetIt.I.get<SearchRepo>().search(
        query: query,
        type: type,
      );
      emit(SearchLoaded(searchResult: result, type: type));
    } catch (e) {
      if (e is ApiException) {
        debugPrint('Search failed: ${e.message}');
      } else {
        debugPrint('Unexpected error: $e');
      }
    }
  }
}
