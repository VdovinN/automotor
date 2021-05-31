import 'package:automotor/model/search_result_model.dart';

abstract class SearchResultState {
  const SearchResultState();
}

class DefaultSearchResultState extends SearchResultState {}

class LoadingSearchResultState extends SearchResultState {}

class SuccessSearchResultState extends SearchResultState {
  final SearchResultModel item;

  const SuccessSearchResultState(this.item);
}

class FailureSearchResultState<T> extends SearchResultState {
  final T error;

  const FailureSearchResultState(this.error);
}