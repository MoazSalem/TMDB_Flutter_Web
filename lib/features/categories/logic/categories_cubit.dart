import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/features/categories/data/repo/categories_repo.dart';
import 'package:tmdb_web/core/networking/constants.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  getCategories({
    required String type,
    required List<Category> categories,
  }) async {
    emit(CategoriesLoading());
    List<List<dynamic>> result = [];
    for (Category category in categories) {
      result.add(
        await GetIt.I.get<CategoriesRepo>().getCategory(type, category),
      );
    }
    emit(
      CategoriesLoaded(
        firstCategoryList: result[0],
        secondCategoryList: result[1],
        thirdCategoryList: result[2],
        fourthCategoryList: result[3],
      ),
    );
  }
}
