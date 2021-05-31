import 'package:automotor/model/search_suggestion_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchStateDefault extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<SearchSuggestionModel> items;

  const SearchStateSuccess(this.items);
}

class SearchStateError extends SearchState {
  final String error;

  const SearchStateError(this.error);
}