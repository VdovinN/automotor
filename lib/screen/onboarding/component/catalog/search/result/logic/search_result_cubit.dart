import 'package:automotor/model/server_error.dart';
import 'package:automotor/repository/search_repository.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/search_result_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit({@required this.searchRepository}) : super(LoadingSearchResultState());

  final SearchRepository searchRepository;

  Future<void> fetchSearchResultList(
    String searchQuery,
    String source,
    String subCategoryId,
    String manSupId,
    String replacement, {
    List<int> manufacturerIdList = const [],
    List<String> dataSupplierIdList = const [],
  }) async {
    emit(LoadingSearchResultState());
    try {
      final items = await searchRepository.searchResultsByReference(
        searchQuery,
        source,
        subCategoryId,
        manSupId,
        replacement,
        manufacturerIdList,
        dataSupplierIdList,
      );
      emit(SuccessSearchResultState(items));
    } catch (error) {
      if(error is ServerError) {
        emit(FailureSearchResultState(error.message));
      } else {
        emit(FailureSearchResultState("Something went wrong!"));
      }
    }
  }
}
