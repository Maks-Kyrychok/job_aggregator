import 'package:dartz/dartz.dart';
import 'package:job_aggregator/feature/domain/entities/job_entity.dart';

import '../../../core/error/failure.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getAllJobs();
  Either<Failure, JobEntity> postJobs();
  Future<Either<Failure, List<JobEntity>>> getJobsById(int id);
}
