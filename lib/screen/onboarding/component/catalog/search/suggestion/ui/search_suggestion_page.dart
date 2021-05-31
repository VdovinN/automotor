import 'package:auto_size_text/auto_size_text.dart';
import 'package:automotor/model/search_suggestion_model.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/ui/search_results_page.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/suggestion/logic/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/search_bloc.dart';
import '../logic/search_event.dart';

class SearchSuggestionPage extends StatelessWidget {
  static const routeName = "/search_form";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[_SearchBar(), _SearchBody()],
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      autofocus: true,
      onChanged: (text) {
        _searchBloc.add(
          SearchSuggestionEvent(text: text),
        );
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          child: Icon(Icons.clear),
          onTap: _onClearTapped,
        ),
        border: InputBorder.none,
        hintText: "Search by reference...",
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _searchBloc.add(SearchSuggestionEvent(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (BuildContext context, SearchState state) {
        if (state is SearchStateDefault) {
          return Text("Please enter a reference code to begin");
        } else if (state is SearchStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchStateError) {
          return Center(child: Text(state.error));
        } else if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? Center(child: Text("No Results"))
              : Expanded(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: getSearchListView(state.items),
                ));
        } else {
          return Container();
        }
      },
    );
  }
}

Widget getSearchListView(List<SearchSuggestionModel> results) =>
    ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(height: 1.0, color: Colors.black),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int position) {
        final result = results[position];
        return GestureDetector(
          child: getRow(result),
          onTap: () {
            Navigator.pushNamed(
              context,
              SearchResultPage.routeName,
              arguments: SearchResultArguments(
                result.reference,
                result.source,
                result.subCategoryId,
                result.manSupId,
                result.replacement,
              ),
            );
          },
        );
      },
    );

Widget getRow(SearchSuggestionModel result) {
  return Container(
    height: 50.0,
    child: Row(
      children: [
        Expanded(
          flex: 30,
          child: AutoSizeText(
            '${result.reference}',
            style: TextStyle(fontSize: 16),
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 40,
          child: AutoSizeText(
            '${result.supplierOfManufacturer}',
            style: TextStyle(fontSize: 16),
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 30,
          child: AutoSizeText(
            '${result.categoryName}',
            style: TextStyle(fontSize: 16),
            maxLines: 2,
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );
}
