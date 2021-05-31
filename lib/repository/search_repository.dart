import 'package:automotor/datasource/search_client.dart';
import 'package:automotor/model/filter_model.dart';
import 'package:automotor/model/search_result_model.dart';
import 'package:automotor/model/search_suggestion_model.dart';

class SearchRepository {
  SearchRepository(this.searchService);

  final SearchService searchService;

  Future<List<SearchSuggestionModel>> searchSuggestions(String query) async {
    return await searchService.searchSuggestionsByReference(query);
  }

  Future<SearchResultModel> searchResultsByReference(
    String searchQuery,
    String source,
    String subCategoryId,
    String manSupId,
    String replacement,
    List<int> manufacturerIdList,
    List<String> dataSupplierIdList,
  ) async {
    return await searchService.searchResultsByReference(
      searchQuery,
      source,
      subCategoryId,
      manSupId,
      replacement,
      manufacturerIdList,
      dataSupplierIdList,
    );
  }

  Future<FilterModel> fetchFilters(
    String searchQuery,
    String source,
    String subCategoryId,
    String manSupId,
    String replacement,
  ) async {
    return await searchService.filterByReference(
        searchQuery, source, subCategoryId, manSupId, replacement);
  }
}
