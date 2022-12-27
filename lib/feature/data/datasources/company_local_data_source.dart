import 'dart:convert';

import 'package:job_aggregator/core/error/exception.dart';
import 'package:job_aggregator/feature/data/models/company_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CompanyLocalDataSource {
  /// Gets the cached [List<CompanyModel>] which was gotten the last time
  /// the user had an internet conection
  ///
  /// Throws [CacheException] if on cached data is present.

  Future<List<CompanyModel>> getLastCompaniesFromCache();
  Future<void> companiesToCache(List<CompanyModel> companys);
}

const CACHED_COMPANY_LIST = 'CACHED_COMPANY_LIST';

class CompanyLocalDataSourceImpl implements CompanyLocalDataSource {
  final SharedPreferences sharedPreferences;

  CompanyLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> companiesToCache(List<CompanyModel> companies) {
    final List<String> jsonCompaniesList =
        companies.map((company) => jsonEncode(company.toJson())).toList();
    sharedPreferences.setStringList(CACHED_COMPANY_LIST, jsonCompaniesList);
    print('Company to write Cache: ${jsonCompaniesList.length}');
    return Future.value(jsonCompaniesList);
  }

  @override
  Future<List<CompanyModel>> getLastCompaniesFromCache() {
    final jsonCompaniesList =
        sharedPreferences.getStringList(CACHED_COMPANY_LIST);
    if (jsonCompaniesList != null) {
      return Future.value(jsonCompaniesList
          .map((company) => CompanyModel.fromJson(jsonDecode(company)))
          .toList());
    } else {
      throw CacheExeption();
    }
  }
}
