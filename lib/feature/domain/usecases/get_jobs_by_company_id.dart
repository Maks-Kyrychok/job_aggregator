import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_aggregator/core/usecases/usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class GetJobsByCompanyId extends UseCase<List<JobEntity>, AllCompanyJobs> {
  final JobRepository jobRepository;
  GetJobsByCompanyId(this.jobRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(AllCompanyJobs params) async {
    return await jobRepository.getJobsByCompanyId(params.companyId);
  }
}

class AllCompanyJobs extends Equatable {
  final int companyId;

  const AllCompanyJobs(this.companyId);
  @override
  List<Object?> get props => [companyId];
}
