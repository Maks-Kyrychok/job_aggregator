import 'dart:convert';

import 'package:job_aggregator/core/error/exception.dart';

import '../models/company_model.dart';
import 'package:http/http.dart' as http;

abstract class CompanyRemoteDataSource {
  /// Calls the http://3.75.134.87/flutter/v1/companies endpoint.
  Future<List<CompanyModel>> getAllCompanies();

  /// Calls the http://3.75.134.87/flutter/v1/companies endpoint.
  postCompany();

  /// Calls the http://3.75.134.87/flutter/v1/companies/{id} endpoint.
  deleteCompany(int id);
}

class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final http.Client client;

  CompanyRemoteDataSourceImpl({required this.client});

  @override
  deleteCompany(int id) {
    // TODO: implement deleteCompany
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyModel>> getAllCompanies() async {
    final response =
        await client.get(Uri.parse('http://3.75.134.87/flutter/v1/companies'));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> companies = map["result"];
      return (companies).map((data) => CompanyModel.fromJson(data)).toList();
    } else {
      throw ServerExeption();
    }
  }

  @override
  postCompany() {
    // TODO: implement postCompany
    throw UnimplementedError();
  }
}
