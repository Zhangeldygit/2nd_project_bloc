part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}


class LoadProducts extends CategoryEvent{}

class SearchProductEvent extends CategoryEvent{
  final String filter;
  SearchProductEvent(this.filter);
}