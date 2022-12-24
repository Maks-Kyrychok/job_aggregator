import 'package:dartz/dartz.dart';
import 'package:job_aggregator/feature/domain/entities/job_entity.dart';
import 'package:job_aggregator/feature/domain/usecases/get_jobs_by_company_id.dart';

import '../../../core/error/failure.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getAllJobs();
  Future<Either<Failure, List<JobEntity>>> getJobsByCompanyId(int companyId);
  Either<Failure, JobEntity> postJobs();
}
