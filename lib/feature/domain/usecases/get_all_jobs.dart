import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_aggregator/core/usecases/usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class GetAllJobs extends UseCase<List<JobEntity>, PageJobParams> {
  final JobRepository jobRepository;

  GetAllJobs(this.jobRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(PageJobParams params) async {
    return await jobRepository.getAllJobs();
  }
}

class PageJobParams extends Equatable {
  @override
  List<Object?> get props => [];
}
