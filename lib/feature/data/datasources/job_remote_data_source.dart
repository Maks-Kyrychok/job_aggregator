import 'dart:convert';

import 'package:job_aggregator/core/error/exception.dart';
import 'package:job_aggregator/feature/data/models/job_model.dart';

import 'package:http/http.dart' as http;

abstract class JobRemoteDataSource {
  /// Calls the http://3.75.134.87/flutter/v1/jobs endpoint.
  Future<List<JobModel>> getAllJobs();

  /// Calls the http://3.75.134.87/flutter/v1/jobs endpoint.
  postJob();

  /// Calls the http://3.75.134.87/flutter/v1/companies/{company_id}/jobs/ endpoint.
  Future<List<JobModel>> getJobsByCompanyId(int id);

  /// Calls the http://3.75.134.87/flutter/v1/jobs/{id} endpoint.
  deleteJob(int id);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final http.Client client;

  JobRemoteDataSourceImpl({required this.client});

  @override
  deleteJob(int id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<List<JobModel>> getAllJobs() =>
      _getJobsFromUrl('http://3.75.134.87/flutter/v1/jobs');

  @override
  Future<List<JobModel>> getJobsByCompanyId(int companyId) =>
      _getJobsFromUrl('http://3.75.134.87/flutter/v1/companies/$companyId/jobs/');

  @override
  postJob() {
    // TODO: implement postJob
    throw UnimplementedError();
  }

  Future<List<JobModel>> _getJobsFromUrl(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final companies = json.decode(response.body);
      return (companies as List)
          .map((company) => JobModel.fromJson(company))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
