import 'package:equatable/equatable.dart';

abstract class JobsSearchEvent extends Equatable {
  const JobsSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchJobs extends JobsSearchEvent {
  final String jobQuery;

  const SearchJobs({required this.jobQuery});
}
