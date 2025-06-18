part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  // A map where the key is the Category and the value is the list of items.
  final Map<Category, List<dynamic>> categoryData;

  CategoriesLoaded({required this.categoryData});
}
