import 'package:equatable/equatable.dart';

import '../../../../domain/entities/job_entity.dart';

abstract class JobsSearchState extends Equatable {
  const JobsSearchState();
  @override
  List<Object?> get props => [];
}

class JobsSearchEmpty extends JobsSearchState {}

class JobsSearchLoading extends JobsSearchState {}

class JobsSearchLoaded extends JobsSearchState {
  final List<JobEntity> jobs;

  const JobsSearchLoaded({required this.jobs});
  @override
  List<Object?> get props => [jobs];
}

class JobsSearchError extends JobsSearchState {
  final String message;

  const JobsSearchError({required this.message});
  @override
  List<Object?> get props => [message];
}
