import 'package:bloc/bloc.dart';
import 'package:job_aggregator/core/error/failure.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_companies.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_jobs.dart';

import '../../../domain/entities/job_entity.dart';
import 'job_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cached Failure';

class JobListCubit extends Cubit<JobState> {
  final GetAllJobs getAllJobs;
  JobListCubit({required this.getAllJobs}) : super(JobEmpty());

  void loadJob() async {
    if (state is JobLoading) return;
    final currentState = state;
    var oldJobs = <JobEntity>[];
    if (currentState is JobLoaded) {
      oldJobs = currentState.jobsList;
    }

    emit(JobLoading(
      oldJobs,
    ));

    final failureOrJob = await getAllJobs(PageJobParams());
    failureOrJob.fold(
        (error) => emit(JobError(message: _mapFailureToMessage(error))), (job) {
      final jobs = (state as JobLoading).oldJobList;
      jobs.addAll(job);
      emit(JobLoaded(job));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
