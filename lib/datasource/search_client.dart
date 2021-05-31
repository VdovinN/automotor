import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:automotor/model/filter_model.dart';
import 'package:automotor/model/search_result_model.dart';
import 'package:automotor/model/search_suggestion_model.dart';
import 'package:automotor/model/server_error.dart';
import 'package:http/http.dart' as http;

const String _TOKEN =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2MjIxODUxNzMsImV4cCI6MTYyMjIxNzU3Mywicm9sZXMiOlsiUk9MRV9DTElFTlRfQVVUT01PVE9SX0FNRVJJR08iLCJST0xFX0FETUlOIiwiUk9MRV9TVVBFUl9BRE1JTiJdLCJ1c2VybmFtZSI6ImRtaXRyaWkuY29jb3JpbkBmZWVsLWl0LXNlcnZpY2VzLmNvbSJ9.KgZfoM5OyqghCwt_rMVRftOlbAAXYISxnogmAACo_oVYXB733A-MuiAdoVnCTmNVUvpcRDt2kv2eX92a-FXktOZ_2QfcgAYAiwKahpvYOF5XAjjiNF3-bJm40rb83DjiuTQHoQTIQKrS11XCcG6IClqCI_m7vMg5ksavf9j1geO8q3lOSdv9OIH6CNy_LQvl4nPN3khenUQ5fQk-PT31H5zjl8bCsO5hlYGfAJtbA7vx6ZHa_nEP5pVjtbCJdBce1nrGCIHEUU6kh5mmBk29pWqXKk7KKmD9lHcwHlC2z8Va6oQ1SeLDTHwW4LhUFMUy2U4lyIo2kHC6JHJpvkU999o-vhnsyL66gLuzZtE0u6CTu-8Y7jFA8XXfv0RYZkxt_4L43sKmi8xQc_kurdBT05WjMH0vNBiq4l7BuOwjceuWgpKJcTmJKbLNTSO8Z7q6YPNwLWQqT5m7gTn4s9GX4QxHiKhN3V1gwmjwH9wjb-8DU0r4V35masRsdT5sjfT0m_PFwRIm2SrwS1fVZkrD3bQ9cfycpho_vAzDr_MW2F8IJRjy2FGTCJ18Z2u0eMutlbHfBsdYQ6e3w1iPyne7MZWr-zeP4v-c7AGI_cJS-Eu1wNCkqDVT6DvYsc_CNSpE0vyzbLGbRazPk_lkD8gkgjihGEGLtr6_MttCqAtk8tc";

class SearchService {
  Future<List<SearchSuggestionModel>> searchSuggestionsByReference(
    String reference,
  ) async {
    final response = await http.get(
        Uri.parse(
            "http://automotor-api-recette.amerigointernational.pro/en_FR/api/reliable/autocomplete/search?q=$reference"),
        headers: {HttpHeaders.authorizationHeader: _TOKEN});

    if (response.statusCode != 200) {
      Map errorMap = jsonDecode(response.body) as Map<String, dynamic>;
      throw ServerError.fromJson(errorMap);
    }

    String content = response.body;
    List collection = json.decode(content);
    List<SearchSuggestionModel> _searchSuggestions =
        collection.map((json) => SearchSuggestionModel.fromJson(json)).toList();

    return _searchSuggestions;
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
    String manQueryParams = "";
    if (manufacturerIdList.isNotEmpty) {
      for (var i = 0; i < manufacturerIdList.length; i++) {
        manQueryParams += "&man[]=${manufacturerIdList[i]}}";
      }
    }
    String supQueryParams = "";
    if (dataSupplierIdList.isNotEmpty) {
      for (var i = 0; i < dataSupplierIdList.length; i++) {
        supQueryParams += "&sup[]=${dataSupplierIdList[i]}}";
      }
    }
    final response = await http.get(
        Uri.parse(
            'http://automotor-api-recette.amerigointernational.pro/en_FR/api/reliable/car-parts/search?q=$searchQuery&source=$source&subcategory_id=$subCategoryId&man_sup_id=$manSupId&is_amerigo=$replacement$manQueryParams$supQueryParams'),
        headers: {HttpHeaders.authorizationHeader: _TOKEN});

    if (response.statusCode != 200) {
      Map errorMap = jsonDecode(response.body) as Map<String, dynamic>;
      throw ServerError.fromJson(errorMap);
    }

    String content = response.body;
    Map<String, dynamic> collection = json.decode(content);
    SearchResultModel _searchResults = SearchResultModel.fromJson(collection);

    return _searchResults;
  }

  Future<FilterModel> filterByReference(
    String searchQuery,
    String source,
    String subCategoryId,
    String manSupId,
    String replacement,
  ) async {
    final response = await http.get(
        Uri.parse(
            'http://automotor-api-recette.amerigointernational.pro/en_FR/api/reliable/car-parts/filters?q=$searchQuery&source=$source&subcategory_id=$subCategoryId&man_sup_id=$manSupId&is_amerigo=$replacement'),
        headers: {HttpHeaders.authorizationHeader: _TOKEN});

    if (response.statusCode != 200) {
      Map errorMap = jsonDecode(response.body) as Map<String, dynamic>;
      throw ServerError.fromJson(errorMap);
    }

    String content = response.body;
    Map<String, dynamic> collection = json.decode(content);
    FilterModel _filterModel = FilterModel.fromJson(collection);

    return _filterModel;
  }
}
