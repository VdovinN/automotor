import 'package:automotor/model/filter_model.dart';

abstract class FilterState {
  const FilterState();
}

class FilterSuccessState extends FilterState {
  final FilterModel item;

  const FilterSuccessState(this.item);
}

class FilterFailureState extends FilterState {
  const FilterFailureState();
}