import 'dart:convert';

import 'package:job_aggregator/core/error/exception.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/job_model.dart';

abstract class JobLocalDataSource {
  /// Gets the cached [List<JobModel>] which was gotten the last time
  /// the user had an internet conection
  ///
  /// Throws [CacheException] if on cached data is present.

  Future<List<JobModel>> getLastJobsFromCache();
  Future<void> jobsToCache(List<JobModel> companys);
}

const CACHED_JOB_LIST = 'CACHED_JOB_LIST';

class JobLocalDataSourceImpl implements JobLocalDataSource {
  final SharedPreferences sharedPreferences;

  JobLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future jobsToCache(List<JobModel> companies) {
    final List<String> jsonCompaniesList =
        companies.map((company) => jsonEncode(company.toJson())).toList();
    sharedPreferences.setStringList(CACHED_JOB_LIST, jsonCompaniesList);
    return Future.value(jsonCompaniesList);
  }

  @override
  Future<List<JobModel>> getLastJobsFromCache() {
    final jsonJobsList = sharedPreferences.getStringList(CACHED_JOB_LIST);
    if (jsonJobsList != null) {
      return Future.value(jsonJobsList
          .map((company) => JobModel.fromJson(jsonDecode(company)))
          .toList());
    } else {
      throw CacheExeption();
    }
  }
}
