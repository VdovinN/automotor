import 'dart:async';

import 'package:automotor/repository/search_repository.dart';
import 'package:automotor/model/server_error.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/suggestion/logic/search_event.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/suggestion/logic/search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({@required this.searchRepository}) : super(SearchStateDefault());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    Stream<Transition<SearchEvent, SearchState>> Function(
      SearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchSuggestionEvent) {
      final String query = event.text;
      if (query.isEmpty) {
        yield SearchStateDefault();
      } else {
        yield SearchStateLoading();
        try {
          final results = await searchRepository.searchSuggestions(query);
          yield SearchStateSuccess(results);
        } catch (error) {
          yield error is ServerError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
