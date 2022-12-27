import 'package:job_aggregator/feature/data/models/job_model.dart';
import 'package:job_aggregator/feature/domain/entities/job_entity.dart';

import 'package:job_aggregator/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/platform/network_info.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_local_data_source.dart';
import '../datasources/job_remote_data_source.dart';

class JobRepositoryImpl extends JobRepository {
  final JobRemoteDataSource remoteDataSource;
  final JobLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  JobRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<JobEntity>>> getAllJobs() async {
    return await _getJobs(() {
      return remoteDataSource.getAllJobs();
    });
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getJobsByCompanyId(
      int companyId) async {
    return await _getJobs(() {
      return remoteDataSource.getJobsByCompanyId(companyId);
    });
  }

  @override
  Either<Failure, JobEntity> postJobs() {
    // TODO: implement postJobs
    throw UnimplementedError();
  }

  Future<Either<Failure, List<JobModel>>> _getJobs(
      Future<List<JobModel>> Function() getJobs) async {
    if (await networkInfo.isConnected) {
      try {
        final remouteJobs = await getJobs();
        localDataSource.jobsToCache(remouteJobs);
        return Right(remouteJobs);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localJobs = await localDataSource.getLastJobsFromCache();
        return Right(localJobs);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}
