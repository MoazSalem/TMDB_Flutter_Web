part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<dynamic> firstCategoryList;
  final List<dynamic> secondCategoryList;
  final List<dynamic> thirdCategoryList;
  final List<dynamic> fourthCategoryList;

  CategoriesLoaded({
    required this.firstCategoryList,
    required this.secondCategoryList,
    required this.thirdCategoryList,
    required this.fourthCategoryList,
  });
}
