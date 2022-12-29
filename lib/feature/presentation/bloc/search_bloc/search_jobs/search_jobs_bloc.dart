import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:job_aggregator/feature/domain/usecases/get_all_jobs.dart';

import '../../../../../core/error/failure.dart';
import 'search_jobs_event.dart';
import 'search_jobs_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cached Failure';

class JobsSearchBloc extends Bloc<JobsSearchEvent, JobsSearchState> {
  final GetAllJobs searchJobs;

  JobsSearchBloc({required this.searchJobs}) : super(JobsSearchEmpty()) {
    on<SearchJobs>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchJobs event, Emitter<JobsSearchState> emit) async {
    emit(JobsSearchLoading());
    final failureOrJob = await searchJobs.call(PageJobParams());
    emit(failureOrJob.fold(
        (failure) => JobsSearchError(message: _mapFailureToMessage(failure)),
        (jobs) => JobsSearchLoaded(jobs: jobs)));
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
