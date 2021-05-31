import 'package:automotor/repository/search_repository.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/filter_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit({@required this.searchRepository}) : super(null);

  final SearchRepository searchRepository;

  Future<void> fetchFilters(
    String searchQuery,
    String source,
    String subCategoryId,
    String manSupId,
    String replacement,
  ) async {
    try {
      final items = await searchRepository.fetchFilters(
        searchQuery,
        source,
        subCategoryId,
        manSupId,
        replacement,
      );
      emit(FilterSuccessState(items));
    } catch (_) {
      emit(FilterFailureState());
    }
  }
}
