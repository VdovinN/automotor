class SearchSuggestionModel {
  final String reference;
  final String supplierOfManufacturer;
  final String categoryName;
  final String source;
  final String subCategoryId;
  final int manSupId;
  final int replacement;

  SearchSuggestionModel(this.reference, this.supplierOfManufacturer, this.categoryName,
      this.source, this.subCategoryId, this.manSupId, this.replacement);

  SearchSuggestionModel.fromJson(Map<String, dynamic> json)
      : reference = json['reference'],
        supplierOfManufacturer = json['supplier_or_manufacturer'],
        categoryName = json['category_name'],
        source = json['source'],
        subCategoryId = json['subcategory_id'],
        manSupId = json['man_sup_id'],
        replacement = json['replacement'];
}
