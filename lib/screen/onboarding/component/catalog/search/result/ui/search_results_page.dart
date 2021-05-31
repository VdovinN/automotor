import 'package:automotor/model/filter_model.dart';
import 'package:automotor/model/search_result_model.dart';
import 'package:automotor/repository/search_repository.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/filter_cubit.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/filter_state.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/search_result_cubit.dart';
import 'package:automotor/screen/onboarding/component/catalog/search/result/logic/search_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultArguments {
  final String searchQuery;
  final String source;
  final String subCategoryId;
  final int manSupId;
  final int replacement;

  SearchResultArguments(this.searchQuery, this.source, this.subCategoryId,
      this.manSupId, this.replacement);
}

class SearchResultPage extends StatefulWidget {
  static const routeName = "/search_result_page";

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    final SearchResultArguments args =
    ModalRoute
        .of(context)
        .settings
        .arguments as SearchResultArguments;

    return BlocProvider(
      create: (_) =>
      SearchResultCubit(
        searchRepository: context.read<SearchRepository>(),
      )
        ..fetchSearchResultList(
          args.searchQuery,
          args.source,
          args.subCategoryId,
          args.manSupId.toString(),
          args.replacement.toString(),
        ),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: BlocProvider(
              create: (_) =>
              FilterCubit(
                  searchRepository: context.read<SearchRepository>())
                ..fetchFilters(
                  args.searchQuery,
                  args.source,
                  args.subCategoryId,
                  args.manSupId.toString(),
                  args.replacement.toString(),
                ),
              child: AppBar(
                title: Text("Car Parts"),
                actions: [
                  FilterView(
                    searchQuery: args.searchQuery,
                    source: args.source,
                    subCategoryId: args.subCategoryId,
                    manSupId: args.manSupId,
                    replacement: args.replacement,
                  ),
                ],
              ),
            ),
          ),
          body: SearchResultListView()),
    );
  }
}

class FilterView extends StatelessWidget {
  FilterView({
    this.searchQuery,
    this.source,
    this.subCategoryId,
    this.manSupId,
    this.replacement,
  });

  final String searchQuery;
  final String source;
  final String subCategoryId;
  final int manSupId;
  final int replacement;

  final carManufacturerIdList = <int>[];
  final dataSupplierIdList = <String>[];

  @override
  Widget build(BuildContext context) {
    final state = context
        .watch<FilterCubit>()
        .state;
    if (state is FilterSuccessState) {
      final carManufacturers = state.item.carManufacturers;
      final dataSuppliers = state.item.dataSuppliers;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showFilterDialog(
                    context: context,
                    carManufacturers: carManufacturers,
                    dataSuppliers: dataSuppliers,
                  );
                }).then((_) {
              context.read<SearchResultCubit>().fetchSearchResultList(
                searchQuery,
                source,
                subCategoryId,
                manSupId.toString(),
                replacement.toString(),
                manufacturerIdList: carManufacturerIdList,
                dataSupplierIdList: dataSupplierIdList,
              );
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

  showFilterDialog({
    BuildContext context,
    List<CarManufacturers> carManufacturers,
    List<DataSuppliers> dataSuppliers,
  }) {
    return StatefulBuilder(
      builder: (context, setState) =>
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Supplier",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight: 0.0,
                            minWidth: 0.0,
                            maxHeight: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                            maxWidth: double.infinity,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataSuppliers.length,
                            itemBuilder: (BuildContext context, int index) {
                              final supplier = dataSuppliers[index];
                              return CheckboxListTile(
                                title: Text(supplier.name),
                                value: dataSupplierIdList.contains(supplier.id),
                                onChanged: (bool isSelected) {
                                  setState(() {
                                    isSelected
                                        ? dataSupplierIdList.add(supplier.id)
                                        : dataSupplierIdList.remove(
                                        supplier.id);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Text(
                          "Brand",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight: 0.0,
                            minWidth: 0.0,
                            maxHeight: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                            maxWidth: double.infinity,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: carManufacturers.length,
                            itemBuilder: (BuildContext context, int index) {
                              final carManufacturer = carManufacturers[index];
                              return CheckboxListTile(
                                title: Text(carManufacturer.name),
                                value: carManufacturerIdList
                                    .contains(carManufacturer.id),
                                onChanged: (bool isSelected) {
                                  setState(() {
                                    isSelected
                                        ? carManufacturerIdList
                                        .add(carManufacturer.id)
                                        : carManufacturerIdList
                                        .remove(carManufacturer.id);
                                  });
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchResultCubit, SearchResultState>(
      builder: (context, state) {
        if (state is SuccessSearchResultState) {
          final SearchResultModel model = state.item;
          return _getBody(model.data);
        } else if (state is FailureSearchResultState) {
          final String errorMessage = state.error;
          return Center(child: Text(errorMessage));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _getBody(List<Data> dataList) {
    return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int position) {
          final data = dataList[position];
          final bool isAvailable = (data.available != 0);
          final bool hasPrice = (data.price != 0);
          final String euroSymbol = "\u20ac";
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              height: 80.0,
              child: Row(
                children: [
                  Image.network(data.image),
                  Expanded(
                    child: ListTile(
                      title: Text(data.name),
                      subtitle: Text(data.carParts[0].subcategory.name),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          hasPrice
                              ? "$euroSymbol${data.price}"
                              : "$euroSymbol-",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Add to cart"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Availability:"),
                            Icon(
                              Icons.circle,
                              color: isAvailable ? Colors.green : Colors.red,
                              size: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
