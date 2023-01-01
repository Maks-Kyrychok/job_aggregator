import 'package:dartz/dartz.dart';
import 'package:job_aggregator/feature/domain/entities/job_entity.dart';

import '../../../core/error/failure.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getAllJobs();
  Future<Either<Failure, List<JobEntity>>> getJobsByCompanyId(int companyId);
  Either<Failure, JobEntity> postJobs();
}
