import 'package:automotor/screen/onboarding/component/catalog/search/result/ui/search_results_page.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/suggestion/logic/search_bloc.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/suggestion/ui/search_suggestion_page.dart';
import 'package:automotor/screen/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../datasource/search_client.dart';
import '../repository/search_repository.dart';

var searchRepository = SearchRepository(SearchService());

final Map<String, WidgetBuilder> routes = {
  OnBoardingPage.routeName: (context) => OnBoardingPage(),
  SearchSuggestionPage.routeName: (context) {
    return BlocProvider(
      create: (context) {
        return SearchBloc(searchRepository: searchRepository);
      },
      child: SearchSuggestionPage(),
    );
  },
  SearchResultPage.routeName: (context) {
    return RepositoryProvider.value(
      value: searchRepository,
      child: SearchResultPage(),
    );
  },
};
