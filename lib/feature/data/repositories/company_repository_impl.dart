import 'package:job_aggregator/core/error/exception.dart';
import 'package:job_aggregator/core/platform/network_info.dart';
import 'package:job_aggregator/feature/data/datasources/company_local_data_source.dart';
import 'package:job_aggregator/feature/data/datasources/company_remote_data_source.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

import 'package:job_aggregator/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final CompanyRemoteDataSource remoteDataSource;
  final CompanyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CompanyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CompanyEntity>>> getAllCompanies() async {
    if (await networkInfo.isConnected) {
      try {
        final remouteCompany = await remoteDataSource.getAllCompanies();
        localDataSource.companiesToCache(remouteCompany);
        return Right(remouteCompany);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCompany = await localDataSource.getLastCompaniesFromCache();
        return Right(localCompany);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Either<Failure, CompanyEntity> postCompany() {
    // TODO: implement postCompany
    throw UnimplementedError();
  }
}
