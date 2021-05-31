abstract class SearchEvent {
  const SearchEvent();
}

class SearchSuggestionEvent extends SearchEvent {
  SearchSuggestionEvent({this.text});

  final String text;
}
