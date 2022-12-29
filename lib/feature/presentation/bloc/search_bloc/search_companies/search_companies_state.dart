import 'package:equatable/equatable.dart';
import 'package:job_aggregator/feature/domain/entities/company_entity.dart';

abstract class CompaniesSearchState extends Equatable {
  const CompaniesSearchState();
  @override
  List<Object?> get props => [];
}

class CompaniesSearchEmpty extends CompaniesSearchState {}

class CompaniesSearchLoading extends CompaniesSearchState {}

class CompaniesSearchLoaded extends CompaniesSearchState {
  final List<CompanyEntity> companies;

  const CompaniesSearchLoaded({required this.companies});
  @override
  List<Object?> get props => [companies];
}

class CompaniesSearchError extends CompaniesSearchState {
  final String message;

  const CompaniesSearchError({required this.message});
  @override
  List<Object?> get props => [message];
}

